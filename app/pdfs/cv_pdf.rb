# frozen_string_literal: true

class CvPdf < Prawn::Document
  SIDEBAR_WIDTH = 200
  GUTTER = 20

  # The main column starts below the header, which is only drawn on page one.
  # Without this, Prawn keeps the box in the same place on every page and the
  # content that flows over restarts with an empty band at the top.
  module FlowFromPageTop
    def move_past_bottom
      pages_before = @document.page_count
      super
      @document.paint_sidebar_section_bg(@document.profile) if @document.page_count > pages_before
      @document.y = @document.margin_box.absolute_top
    end
  end

  attr_reader :profile

  def initialize(profile)
    super(page_size: 'A4', margin: 40)

    @profile = profile

    setup_fonts
    draw_layout
  end

  # -----------------------
  # LAYOUT
  # -----------------------
  def draw_layout
    draw_header(@profile)
    top = cursor

    draw_sidebar(top, @profile)

    go_to_page(1)
    self.y = top
    draw_main(top, @profile)
  end

  def draw_header(profile)
    height = 100
    y = cursor

    fill_color profile.header_style.bg_color.remove('#')
    fill_rectangle [0, y], bounds.width, height

    fill_color profile.header_style.text_color.remove('#')

    padding_x = 15
    padding_y = 25

    bounding_box([padding_x, y - padding_y], width: bounds.width - (padding_x * 2)) do
      text profile.full_name.to_s.upcase, size: profile.header_style.font_size,
                                          style: (profile.header_style.bold ? :bold : :normal)

      move_down 5

      text profile.title.to_s.upcase, size: 18, color: 'DDDDDD'
    end
  end

  # -----------------------
  # SIDEBAR
  # -----------------------
  def draw_sidebar(top, profile)
    sidebar_bg = profile.sidebar_style.bg_color.remove('#')
    sidebar_fg = profile.sidebar_style.text_color.remove('#')
    padding = 10

    fill_color sidebar_bg
    fill_rectangle [0, top - 28], SIDEBAR_WIDTH, bounds.height - 45

    fill_color sidebar_fg

    bounding_box([padding, top - 28], width: SIDEBAR_WIDTH - (padding * 2)) do
      sidebar_section('PROFILE', profile) do
        text profile.summary.to_s, size: 9, leading: 2
      end

      sidebar_section('CONTACT', profile) do
        icon_text('phone', profile.phone) if profile.phone.present?
        icon_text('email', profile.email) if profile.email.present?
        icon_text('pin_drop', profile.location) if profile.location.present?
        icon_text('github', profile.github_url) if profile.github_url
        icon_text('linkedin', profile.linkedin_url) if profile.linkedin_url.present?
      end

      sidebar_section('SKILLS', profile) do
        profile.skills.each do |skill|
          text "• #{skill.name} #{skill.level}%", size: 9

          bar_width = 180.0
          bar_height = 4.0
          level_width = bar_width * skill.level / 100.0
          y_position = cursor - 2

          stroke_rectangle [bounds.left, y_position], bar_width, bar_height
          fill_rectangle   [bounds.left, y_position], level_width, bar_height

          move_down 10
        end
      end

      if profile.languages.any?
        advance_sidebar(languages_section_height(profile), profile)
        sidebar_section('LANGUAGES', profile) do
          profile.languages.each do |lang|
            text "#{lang.name} — #{lang.level}", size: 9
          end
        end
      end
    end
  end

  def advance_sidebar(section_height, profile)
    prev_page = page_number
    ensure_space(section_height)
    return if page_number == prev_page

    paint_sidebar_section_bg(profile)
  end

  def paint_sidebar_section_bg(profile)
    sidebar_bg = profile.sidebar_style.bg_color.remove('#')

    save_graphics_state
    canvas do
      fill_color sidebar_bg
      fill_rectangle([margin_box.absolute_left, margin_box.absolute_top], SIDEBAR_WIDTH, margin_box.height)
    end
    restore_graphics_state
  end

  def languages_section_height(profile)
    50 + (profile.languages.count * 13) + 10
  end

  # -----------------------
  # MAIN CONTENT
  # -----------------------
  def draw_main(top, profile)
    bounding_box([SIDEBAR_WIDTH + GUTTER, top - 25], width: bounds.width - SIDEBAR_WIDTH - GUTTER) do
      bounds.extend(FlowFromPageTop)

      section_title('EXPERIENCE', profile)

      profile.experiences.order(start_date: :desc).each do |exp|
        text exp.position.to_s, style: :bold, size: 11, color: '555555'
        text "#{exp.company_name}, #{exp.location}", size: 10, color: '555555'
        text date_range(exp), size: 9, color: '999999'

        move_down 5

        exp.experience_items.each do |item|
          text "• #{item.content}", size: 10, leading: 2, color: '555555'
        end

        move_down 12
      end

      ensure_space(150)
      section_title('CERTIFICATES', profile) if profile.certificates.any?
      profile.certificates.each do |cert|
        text "#{cert.name} — #{cert.provider} — #{cert.issue_date.strftime('%b %Y')}",
             size: 10, color: '555555'
      end
      move_down 12

      ensure_space(150)
      section_title('PROJECTS', profile) if profile.projects.any?
      profile.projects.each do |project|
        text project.name.to_s, style: :bold, size: 11, color: '555555'
        text project.description.to_s, size: 11, color: '555555'
        text project.github_url.to_s, size: 10, color: '555555'
        text project.live_url.to_s, size: 10, color: '555555'
      end

      section_title('EDUCATION', profile) if profile.educations.any?
      profile.educations.each do |edu|
        text edu.degree.to_s, style: :bold, size: 10, color: '555555'
        text "#{edu.institution}, #{edu.location}", size: 9, color: '555555'
        text "#{edu.start_date.year} - #{edu.end_date.year}", size: 9, color: '555555'
      end
      move_down 12
    end
  end

  # -----------------------
  # HELPERS
  # -----------------------
  def sidebar_section(title, profile)
    move_down 15
    text title, size: 14, style: (profile.header_style.bold ? :bold : :normal)
    stroke_color 'FFFFFF'
    line_width 2
    stroke_horizontal_rule
    move_down 15
    yield
  end

  def icon_text(icon, text_content)
    image_path = Rails.root.join("app/assets/images/icons/#{icon}.png")

    bounding_box([0, cursor], width: bounds.width) do
      image image_path, width: 10, at: [0, cursor]

      text_box text_content,
               size: 9,
               at: [15, cursor],
               width: bounds.width - 15,
               overflow: :truncate,
               min_font_size: 6
    end

    move_down 12
  end

  def section_title(title, profile)
    move_down 10

    height = 20
    y = cursor

    fill_color profile.main_style.text_color.remove('#')
    fill_rectangle [0, y], bounds.width, height
    fill_color 'FFFFFF'

    padding_x = 8
    padding_y = 4

    bounding_box([padding_x, y - padding_y], width: bounds.width - (padding_x * 2)) do
      text title, size: 14, style: :bold
    end

    move_down 5
  end

  def date_range(exp)
    from = exp.start_date&.strftime('%b %Y')
    to = exp.current ? 'Present' : exp.end_date&.strftime('%b %Y')
    "#{from} - #{to}"
  end

  def ensure_space(min_height)
    return if cursor >= min_height

    if page_number < page_count
      go_to_page(page_number + 1)
    else
      start_new_page
      paint_sidebar_section_bg(@profile)
    end

    self.y = margin_box.absolute_top
  end

  def setup_fonts
    font_families.update(
      'Roboto' => {
        normal: Rails.root.join('app/assets/fonts/Roboto-Regular.ttf'),
        bold: Rails.root.join('app/assets/fonts/Roboto-Bold.ttf')
      }
    )
    font 'Roboto'
  end
end

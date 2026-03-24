# frozen_string_literal: true

class CvPdf < Prawn::Document
  SIDEBAR_WIDTH = 200
  GUTTER = 20

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
    draw_header
    top = cursor

    draw_sidebar(top)
    draw_main(top)
  end

  def draw_header
    height = 100
    y = cursor

    fill_color '555555'
    fill_rectangle [0, y], bounds.width, height

    fill_color 'FFFFFF'

    padding_x = 15
    padding_y = 25

    bounding_box([padding_x, y - padding_y], width: bounds.width - (padding_x * 2)) do
      text @profile.full_name.to_s.upcase, size: 22, style: :bold

      move_down 5

      text @profile.title.to_s.upcase, size: 18, color: 'DDDDDD'
    end
  end

  # -----------------------
  # SIDEBAR
  # -----------------------
  def draw_sidebar(top)
    bounding_box([0, top], width: SIDEBAR_WIDTH, height: bounds.height - 45) do
      fill_color '325e7e'
      fill_rectangle [0, top], SIDEBAR_WIDTH, bounds.height
      fill_color 'FFFFFF'

      padding = 10

      bounding_box(
        [padding, top - padding],
        width: SIDEBAR_WIDTH - (padding * 2),
        height: bounds.height - (padding * 2)
      ) do
        move_down 10

        sidebar_section('PROFILE') do
          text @profile.summary.to_s, size: 9, leading: 2
        end

        sidebar_section('CONTACT') do
          icon_text('phone', @profile.phone)
          icon_text('email', @profile.email)
          icon_text('pin_drop', @profile.location)
          icon_text('github', @profile.github_url)
          icon_text('linkedin', @profile.linkedin_url)
        end

        sidebar_section('SKILLS') do
          @profile.skills.each do |skill|
            text "• #{skill.name} #{skill.level}%", size: 9

            bar_width = 180.0
            bar_height = 4.0
            level_width = bar_width * skill.level / 100.0
            y_position = cursor - 2

            stroke_rectangle [bounds.left, y_position], bar_width, bar_height

            fill_rectangle [bounds.left, y_position], level_width, bar_height

            move_down 10
          end
        end

        sidebar_section('LANGUAGES') do
          @profile.languages.each do |lang|
            text "#{lang.name} — #{lang.level}", size: 9
          end
        end

        sidebar_section('EDUCATION') do
          @profile.educations.each do |edu|
            text edu.degree.to_s, style: :bold, size: 10
            text "#{edu.institution}, #{edu.location}", size: 9
            text "#{edu.start_date.year} - #{edu.end_date.year}", size: 9
            move_down 10
          end
        end
      end
    end
  end

  # -----------------------
  # MAIN CONTENT
  # -----------------------
  def draw_main(top)
    bounding_box([SIDEBAR_WIDTH + GUTTER, top - 25], width: bounds.width - SIDEBAR_WIDTH - GUTTER) do
      section_title('EXPERIENCE')

      @profile.experiences.order(start_date: :desc).each do |exp|
        text exp.position.to_s, style: :bold, size: 11, color: '555555'
        text "#{exp.company_name}, #{exp.location}", size: 10, color: '555555'
        text date_range(exp), size: 9, color: '999999'

        move_down 5

        exp.experience_items.each do |item|
          text "• #{item.content}", size: 10, leading: 2, color: '555555'
        end

        move_down 12
      end

      section_title('CERTIFICATES')
      @profile.certificates.each do |cert|
        text "#{cert.name} — #{cert.provider} — #{cert.issue_date.strftime('%b %Y')}",
             size: 10, color: '555555'
      end
    end
  end

  # -----------------------
  # HELPERS
  # -----------------------
  def sidebar_section(title)
    move_down 15
    text title, size: 14, style: :bold, color: 'FFFFFF'
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

  def section_title(title)
    move_down 10

    height = 20
    y = cursor

    fill_color '555555'
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

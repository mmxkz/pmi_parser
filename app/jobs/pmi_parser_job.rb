class PmiParserJob < ApplicationJob
  PMI_URL = "spec/files/pmi_example.html".freeze
  COLUMN = %w(name city country credential earned status).freeze

  queue_as :pmi_parser

  def perform
    parsed_users = parse_users(parse_page)

    parsed_users.each_with_index do |user_row, index|

      user_data = parse_user(user_row)

      unless user_data.size == COLUMN.size
        user_data = find_last_full_user_row(parsed_users.first(index + 1)) + user_data
      end

      save prepare_params(user_data)
    end
  end

  private

  def find_last_full_user_row(parsed_users)
    parsed_users.reverse_each do |user_row|
      user_data = parse_user(user_row)

      return user_data.first(3) if user_data.size == COLUMN.size
    end
  end

  def parse_page
    Nokogiri::HTML(open(PMI_URL))
  end

  def parse_users(page)
    page.css('tr[id^="dph_RegistryContent_SearchResults"]')
  end

  def parse_user(user_row)
    user_row.css('td').map(&:text).map(&:strip).reject(&:blank?)
  end

  def prepare_params(data)
    [COLUMN, data].transpose.to_h
  end

  def save(permit_params)
    PmiUser.create permit_params
  end
end

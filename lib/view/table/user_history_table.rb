# frozen_string_literal: true

module Views
  module Table
    # class for creating tables from Users history
    class UserHistoryTable < BaseTable
      def title
        "#{I18n.t('task_title')} \n #{@content[:email]}".colorize(:magenta)
      end

      HEADINGS = %w[make model year_from year_to price_from price_to requests_quantity total_quantity].freeze

      def headings
        HEADINGS.map { |value| I18n.t(value).colorize(:light_blue) }
      end

      def rows
        @content[:content].map { |car| car.delete(:id) }
        @content[:content].map { |car| car.values.map { |value| value.to_s.colorize(:blue) } }
      end
    end
  end
end

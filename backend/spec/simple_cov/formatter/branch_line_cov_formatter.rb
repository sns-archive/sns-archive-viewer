# frozen_string_literal: true

module SimpleCov
  module Formatter
    class BranchLineCovFormatter
      # テストカバレッジ出力用のコードであるため
      # rubocop:disable all
      def format(result)
        puts 'Coverage Report'
        puts '======================'
        puts "Lines: #{result.covered_lines}/#{result.total_lines} (#{result.covered_percent.round(2)}%)"
        # ワークアラウンドなので、SimpleCov側が対応したら削除する。
        # Ref: https://github.com/simplecov-ruby/simplecov/issues/1051#issuecomment-1426136364
        if result.total_branches&.positive?
          covered_branches_percent = 100.0 * result.covered_branches / result.total_branches
          puts "Branch coverage: #{result.covered_branches} / #{result.total_branches} branches (#{covered_branches_percent.round(2)}%) covered."
        end
        puts '======================'
      end
      # rubocop:enable all
    end
  end
end

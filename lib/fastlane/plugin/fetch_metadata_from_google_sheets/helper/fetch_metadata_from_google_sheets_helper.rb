require "fastlane_core/ui/ui"
require "google_drive"

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class FetchMetadataFromGoogleSheetsHelper
      # class methods that you define here become available in your action
      # as `Helper::FetchMetadataFromGoogleSheetsHelper.your_method`

      def self.make_service_account_key_string_io(
        project_id: String,
        private_key_id: String,
        private_key: String,
        client_email: String,
        client_id: String,
        auth_uri: String,
        token_uri: String,
        auth_provider_x509_cert_url: String,
        client_x509_cert_url: String
      )
        service_account_key_json = {
          type: "service_account",
          project_id: project_id,
          private_key_id: private_key_id,
          private_key: private_key.gsub(/\\n/, "\n"),
          client_email: client_email,
          client_id: client_id,
          auth_uri: auth_uri,
          token_uri: token_uri,
          auth_provider_x509_cert_url: auth_provider_x509_cert_url,
          client_x509_cert_url: client_x509_cert_url
        }.to_json
        StringIO.new(service_account_key_json)
      end

      def self.fetch_google_sheets(service_account_key_stringIO: StringIO, spreadsheet_id: String)
        session = GoogleDrive::Session.from_service_account_key(service_account_key_stringIO)
        session.spreadsheet_by_key(spreadsheet_id)
      end

      def self.save_metadata(spreadsheet: Object, columns: Array, languages: Array)
        languages.each do |language|
          spreadsheet.worksheet_by_title(language).rows.last.each_with_index do |text, index|
            if valid(filename: columns[index])
              File.open(FastlaneCore::FastlaneFolder.path + "metadata/#{language}/#{columns[index]}.txt", "w") { |f| f.puts(text) }
            end
          end
        end
      end

      def self.valid(filename: String)
        ["apple_tv_privacy_policy", "description", "keywords", "marketing_url", "name", "privacy_url", "promotional_text", "release_notes", "subtitle", "support_url"].include?(filename)
      end
    end
  end
end

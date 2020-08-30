require "fastlane/action"
require_relative "../helper/fetch_metadata_from_google_sheets_helper"

module Fastlane
  module Actions
    class FetchMetadataFromGoogleSheetsAction < Action
      def self.run(params)
        UI.message("The fetch_metadata_from_google_sheets plugin is working!")
        service_account_key_string_io = Helper::FetchMetadataFromGoogleSheetsHelper.make_service_account_key_string_io(
          project_id: params[:project_id],
          private_key_id: params[:service_account_private_key_id],
          private_key: params[:service_account_private_key],
          client_email: params[:service_account_client_email],
          client_id: params[:service_account_client_id],
          auth_uri: params[:service_account_auth_uri],
          token_uri: params[:service_account_token_uri],
          auth_provider_x509_cert_url: params[:service_account_auth_provider_x509_cert_url],
          client_x509_cert_url: params[:service_account_client_x509_cert_url]
        )
        spreadsheet = Helper::FetchMetadataFromGoogleSheetsHelper.fetch_google_sheets(
          service_account_key_stringIO: service_account_key_string_io,
          spreadsheet_id: params[:spreadsheet_id]
        )
        Helper::FetchMetadataFromGoogleSheetsHelper.save_metadata(
          spreadsheet: spreadsheet,
          columns: params[:columns],
          languages: params[:languages]
        )
        UI.success("Successfully fetch_metadata_from_google_sheets plugin!")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :languages,
            description: "Support Languages (Google Sheet \"Sheet Name\")",
            sensitive: false,
            is_string: false,
            optional: false
          ),
          FastlaneCore::ConfigItem.new(
            key: :columns,
            description: "Google Sheet Columns",
            sensitive: false,
            is_string: false,
            optional: false
          ),
          FastlaneCore::ConfigItem.new(
            key: :spreadsheet_id,
            description: "App Store Metadata Google Sheet Spreadsheet Id",
            sensitive: true,
            is_string: true,
            optional: false
          ),
          FastlaneCore::ConfigItem.new(
            key: :project_id,
            description: "Google Cloud Platform Project Id",
            sensitive: true,
            is_string: true,
            optional: false
          ),
          FastlaneCore::ConfigItem.new(
            key: :service_account_private_key_id,
            description: "Google Cloud Platform Service Account Private Key Id",
            sensitive: true,
            is_string: true,
            optional: false
          ),
          FastlaneCore::ConfigItem.new(
            key: :service_account_private_key,
            description: "Google Cloud Platform Sevice Account Private Key",
            sensitive: true,
            is_string: true,
            optional: false
          ),
          FastlaneCore::ConfigItem.new(
            key: :service_account_client_email,
            description: "Google Cloud Platform Sevice Account Client Email",
            sensitive: true,
            is_string: true,
            optional: false
          ),
          FastlaneCore::ConfigItem.new(
            key: :service_account_client_id,
            description: "Google Cloud Platform Sevice Account Client Id",
            sensitive: true,
            is_string: true,
            optional: false
          ),
          FastlaneCore::ConfigItem.new(
            key: :service_account_auth_uri,
            description: "Google Cloud Platform Sevice Account Auth URI",
            sensitive: true,
            is_string: true,
            optional: false
          ),
          FastlaneCore::ConfigItem.new(
            key: :service_account_token_uri,
            description: "Google Cloud Platform Sevice Account Token URI",
            sensitive: true,
            is_string: true,
            optional: false
          ),
          FastlaneCore::ConfigItem.new(
            key: :service_account_auth_provider_x509_cert_url,
            description: "Google Cloud Platform Sevice Account Auth Provider X509 Cert URL",
            sensitive: true,
            is_string: true,
            optional: false
          ),
          FastlaneCore::ConfigItem.new(
            key: :service_account_client_x509_cert_url,
            description: "Google Cloud Platform Sevice Account Client X509 Cert URL",
            sensitive: true,
            is_string: true,
            optional: false
          )
        ]
      end

      def self.description
        "Get App Store metadata from Google Sheets."
      end

      def self.details
        "Get App Store metadata from Google Sheets."
      end

      def self.authors
        ["©︎kurarararara https://github.com/kurarararara"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end

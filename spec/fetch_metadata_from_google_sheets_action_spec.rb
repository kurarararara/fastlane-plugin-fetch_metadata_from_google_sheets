describe Fastlane::Actions::FetchMetadataFromGoogleSheetsAction do
  describe "#run" do
    it "prints a message" do
      expect(Fastlane::UI).to receive(:message).with("The fetch_metadata_from_google_sheets plugin is working!")

      Fastlane::Actions::FetchMetadataFromGoogleSheetsAction.run(
        languages: ["ja", "en-US"],
        columns: ["version", "name", "subtitle", "release_notes", "promotional_text", "description", "keywords"],
        spreadsheet_id: ENV["TEST_APP_STORE_METADATA_SPREADSHEET_ID"],
        project_id: ENV["TEST_GCP_PROJECT_ID"],
        service_account_private_key_id: ENV["TEST_GCP_SERVICE_ACCOUNT_PRIVATE_KEY_ID"],
        service_account_private_key: ENV["TEST_GCP_SERVICE_ACCOUNT_PRIVATE_KEY"],
        service_account_client_email: ENV["TEST_GCP_SERVICE_ACCOUNT_CLIENT_EMAIL"],
        service_account_client_id: ENV["TEST_GCP_SERVICE_ACCOUNT_CLIENT_ID"],
        service_account_auth_uri: ENV["TEST_GCP_SERVICE_ACCOUNT_AUTH_URI"],
        service_account_token_uri: ENV["TEST_GCP_SERVICE_ACCOUNT_TOKEN_URI"],
        service_account_auth_provider_x509_cert_url: ENV["TEST_GCP_SERVICE_ACCOUNT_AUTH_PROVIDER_X509_CERT_URL"],
        service_account_client_x509_cert_url: ENV["TEST_GCP_SERVICE_ACCOUNT_CLIENT_X509_CERT_URL"]
      )
    end
  end
end

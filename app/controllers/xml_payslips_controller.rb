class XmlPayslipsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :upload ]

  def upload
    uploaded_file = params[:file]
    return render json: { error: "No file uploaded" }, status: :bad_request if uploaded_file.nil?

    upload_dir = Rails.root.join("public", "uploads")
    FileUtils.mkdir_p(upload_dir) unless File.directory?(upload_dir)

    xml_content = uploaded_file.read
    xml_data = Nokogiri::XML(xml_content) { |config| config.strict.noblanks }

    company = xml_data.at_xpath("//employee/company")&.text || "UnknownCompany"
    emp_id = xml_data.at_xpath("//employee/id")&.text || "UnknownID"
    pay_date = xml_data.at_xpath("//payDetails/payDate")&.text || "UnknownDate"

    filename = "#{company}_#{emp_id}_#{pay_date}.xml"
    filepath = upload_dir.join(filename)

    unless File.exist?(filepath)
      File.open(filepath, "wb") { |file| file.write(xml_content) }
    end

    payslip = Payslip.create!(
      name: xml_data.at_xpath("//employee/name")&.text || "Unknown",
      emp_id: emp_id,
      company: company,
      pay_date: pay_date,
      filename: filename
    )

    render json: { message: "File uploaded successfully", filename: filename }, status: :ok
  rescue Nokogiri::XML::SyntaxError => e
    render json: { error: "Invalid XML format: #{e.message}" }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: "Server error: #{e.message}" }, status: :internal_server_error
  end
end

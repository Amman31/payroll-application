class PayslipsController < ApplicationController
  before_action :set_renderer, only: [ :show, :download_pdf ]
  before_action :set_employee_payslips, only: [ :show ]

  def show
    @employee_id = params[:emp_id]
    @employee_payslips = Payslip.where(emp_id: @employee_id)
  end

  def download_pdf
    filename_with_extension = "#{params[:filename]}.xml"
    xml_file_path = Rails.root.join("public", "uploads", filename_with_extension)

    unless File.exist?(xml_file_path)
      render plain: "Payslip XML file not found", status: 404
      return
    end

    xsl_path = Rails.root.join("app", "files", "MaventaPayslip_2.0.2.xsl")

    @renderer = PayslipRenderer.new(xml_file_path, xsl_path)
    html_content = @renderer.render_html

    grover = Grover.new(html_content, format: "A4")
    pdf = grover.to_pdf

    send_data pdf,
              filename: "payslip_#{params[:filename]}.pdf",
              type: "application/pdf",
              disposition: "attachment"
  end

  private

  def set_renderer
  end

  def set_employee_payslips
    @employee_payslips = Payslip.where(emp_id: params[:emp_id])
  end
end

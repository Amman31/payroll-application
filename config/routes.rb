Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "payslips#show"
  get "/view_payslips/:emp_id", to: "payslips#show", as: "view_payslips"
  get "/download_payslips/:filename", to: "payslips#download_pdf", as: "download_payslip_pdf"
  post "upload_xml", to: "xml_payslips#upload", as: :upload_xml
end

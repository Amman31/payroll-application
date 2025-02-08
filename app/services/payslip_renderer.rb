require "nokogiri"

class PayslipRenderer
  def initialize(xml_path, xsl_path)
    @xml_path = xml_path
    @xsl_path = xsl_path
  end

  # Transform the XML using the XSL file
  def render_html
    xml = Nokogiri::XML(File.read(@xml_path))
    xsl = Nokogiri::XSLT(File.read(@xsl_path))
    xsl.transform(xml).to_s
  end
end

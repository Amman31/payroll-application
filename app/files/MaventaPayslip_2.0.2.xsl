<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" />

  <xsl:template match="/">
    <html>
      <head>
        <title>Payslip</title>
      </head>
      <body style="font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f9;">
        <div style="max-width: 600px; margin: 20px auto; padding: 20px; background: #fff; border: 1px solid #ddd; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
          <h1 style="text-align: center; color: #333;">Payslip</h1>
          <div style="margin-bottom: 20px;">
            <p><strong>Name:</strong> <xsl:value-of select="payslip/employee/name" /></p>
            <p><strong>Finnish ID:</strong> <xsl:value-of select="payslip/employee/id" /></p>
            <p><strong>Department:</strong> <xsl:value-of select="payslip/employee/department" /></p>
            <p><strong>Company:</strong> <xsl:value-of select="payslip/employee/company" /></p>
          </div>
          <div style="margin-bottom: 20px;">
            <table style="width: 100%; border-collapse: collapse;">
              <tr>
                <th style="text-align: left; padding: 8px; border: 1px solid #ddd; background-color: blue; color: white;">Description</th>
                <th style="text-align: left; padding: 8px; border: 1px solid #ddd; background-color: blue; color: white;">Amount</th>
              </tr>
              <tr>
                <td style="text-align: left; padding: 8px; border: 1px solid #ddd;">Basic Pay</td>
                <td style="text-align: left; padding: 8px; border: 1px solid #ddd;"><xsl:value-of select="payslip/payDetails/basicPay" /></td>
              </tr>
              <tr>
                <td style="text-align: left; padding: 8px; border: 1px solid #ddd;">Allowances</td>
                <td style="text-align: left; padding: 8px; border: 1px solid #ddd;"><xsl:value-of select="payslip/payDetails/allowances" /></td>
              </tr>
              <tr>
                <td style="text-align: left; padding: 8px; border: 1px solid #ddd;">Deductions</td>
                <td style="text-align: left; padding: 8px; border: 1px solid #ddd;"><xsl:value-of select="payslip/payDetails/deductions" /></td>
              </tr>
              <tr>
                <td style="text-align: left; padding: 8px; border: 1px solid #ddd; font-weight: bold; background-color: blue; color: white;">Net Pay</td>
                <td style="text-align: left; padding: 8px; border: 1px solid #ddd; font-weight: bold; background-color: blue; color: white;"><xsl:value-of select="payslip/payDetails/netPay" /></td>
              </tr>
            </table>
            <p style="margin-top: 10px;"><strong>Pay Date:</strong> <xsl:value-of select="payslip/payDetails/payDate" /></p>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

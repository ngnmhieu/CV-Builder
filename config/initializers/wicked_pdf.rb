if Rails.env.production?
  wkhtmltopdf_path = Rails.root.join('vendor/bundle/bin/wkhtmltopdf').to_s 
else
  wkhtmltopdf_path = "/usr/local/bin/wkhtmltopdf"            
end

WickedPdf.config = {
  :exe_path => wkhtmltopdf_path
}

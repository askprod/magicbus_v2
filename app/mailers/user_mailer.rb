class UserMailer < ApplicationMailer
    default from: 'MagicBus <hello@magicbusworld.com>'
    default reply_to: 'MagicBus <hello@magicbusworld.com>'
    # layout is in views/layouts/mailer.html.erb
    layout 'layouts/mailer'

    def send_invoice_email(order)
        @order = Order.friendly.find(order.name.downcase)
        attachments["EN_#{@order.name}.pdf"] = WickedPdf.new.pdf_from_string(
            render_to_string(template: 'orders/invoice_pdf.en.html.erb', layout: 'layouts/invoice_pdf_layout.html')
        )
        attachments["FR_#{@order.name}.pdf"] = WickedPdf.new.pdf_from_string(
            render_to_string(template: 'orders/invoice_pdf.fr.html.erb', layout: 'layouts/invoice_pdf_layout.html')
        )
        mail(to: order.user.email, subject: "Invoice for Order #{order.name}", order: @order)
    end

    def send_traveller_booked_email(booker, traveller)
        name = "#{booker.user.first_name} #{booker.user.last_name}"
        @booker = booker
        @traveller = traveller
        mail(to: traveller.email_address, subject: "#{name} has just booked a trip with you included!", traveller: @traveller, booker: @booker)
    end
end

module Stripe
    class EventHandler
      def call(event)
        begin
          method = "handle_" + event.type.tr('.', '_')
          self.send method, event
        rescue JSON::ParserError => e
          raise
        rescue NoMethodError => e
          raise
        rescue Stripe::SignatureVerificationError => e
          raise
        end
      end

      def handle_payment_intent_payment_failed(event)
      end

      def handle_payment_intent_succeeded(event)
      end
    end
end
   
   # method = 'handle_' + event.type.tr('.', '_')
   
   # event.type
   # This will give the name of the event. In our case, it will give ‘charge.dispute.created’ and replace the ‘.’ with ‘_’ so it will become ‘charge_dispute_created’ and concat it with ‘handle_’.
   # so it becomes ‘handle_charge_dispute_created’ as a method.
   
   # send method, event
   
   # This will call the method based on the method variable value. In our case, it will call ‘handle_charge_dispute_created’
   # Same way it will handle the other events based on your events you need to define the method in service put your code in it!
# ActiveMerchantSquare [![Build Status](https://travis-ci.com/imgarylai/active_merchant_square.svg?branch=master)](https://travis-ci.com/imgarylai/active_merchant_square)

Use square gateway with active merchant.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_merchant_square', github: 'imgarylai/active_merchant_square', branch: 'master'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_merchant_square

## Usage

```html

<% param_prefix = "payment_source[#{payment_method.id}]" %>

<div id="square-errors" style="display: none;"></div>
<div class="payment-gateway-fields">
  <div id="square-card-number"></div>
  <div class="third" id="square-expiration-date"></div>
  <div class="third" id="square-cvv"></div>
  <div class="third" id="square-postal-code"></div>
  <%= hidden_field_tag "#{param_prefix}[expiry]", '', {id: 'square-expiry-field'} %>
  <%= hidden_field_tag "#{param_prefix}[cc_type]", '', {id: 'square-cc-type-field'} %>
  <%= hidden_field_tag "#{param_prefix}[gateway_payment_profile_id]", '', {id: 'square-nonce-field'} %>
  <%= hidden_field_tag "#{param_prefix}[last_digits]", '', {id: 'square-last-digits-field'} %>
</div>
<script type="text/javascript" src="https://js.<%= payment_method.preferred_test_mode ? 'squareupsandbox' : 'squareup' %>.com/v2/paymentform">
</script>
<script>
  var applicationId = "<%= payment_method.preferred_application_id %>"
  var locationId = "<%= payment_method.preferred_location_id %>"

  var paymentForm = new SqPaymentForm({
    applicationId: applicationId,
    locationId: locationId,
    inputClass: 'sq-input',
    inputStyles: [{
      fontSize: '14px',
      lineHeight: '24px',
      padding: '16px',
      placeholderColor: '#a0a0a0',
      backgroundColor: 'transparent',
    }],
    cardNumber: {
      elementId: 'square-card-number',
      placeholder: "square card number"
    },
    cvv: {
      elementId: 'square-cvv',
      placeholder: "square cvv"
    },
    expirationDate: {
      elementId: 'square-expiration-date',
      placeholder: 'MM / YY'
    },
    postalCode: {
      elementId: 'square-postal-code',
      placeholder: 'square postal code'
    },
    callbacks: {
      cardNonceResponseReceived: function(errors, nonce, cardData) {
        if (errors) {
          var sortedErrors = errors.sort(error => error.field)
          var errorMsg = sortedErrors.map(error => error.message).join(', ') + '.'
          return
        }


        // convert single month int to value with zero
        var expMonth = ('0' + cardData.exp_month).slice(-2)

        document.getElementById('square-expiry-field').value = expMonth + '/' + cardData.exp_year
        document.getElementById('square-cc-type-field').value = cardData.card_brand.toLowerCase()
        document.getElementById('square-nonce-field').value = nonce
        document.getElementById('square-last-digits-field').value = cardData.last_4
        document.getElementById('checkout_form_payment').submit();
      }
    },
  })
  window.addEventListener('load', function () {
    $('#checkout_form_payment').submit(function (event) {
      paymentForm.requestCardNonce();
      event.preventDefault();
    })
  })
</script>
<style>
  .third {
    float: left;
    width: calc((100% - 32px) / 3);
    padding: 0;
    margin: 0 16px 16px 0;
  }

  .third:last-of-type {
    margin-right: 0;
  }

  /* Define how SqPaymentForm iframes should look */
  .sq-input {
    height: 56px;
    box-sizing: border-box;
    border: 1px solid #E0E2E3;
    background-color: white;
    display: inline-block;
    -webkit-transition: border-color .2s ease-in-out;
    -moz-transition: border-color .2s ease-in-out;
    -ms-transition: border-color .2s ease-in-out;
    transition: border-color .2s ease-in-out;
  }

  /* Define how SqPaymentForm iframes should look when they have focus */
  .sq-input--focus {
    border: 1px solid #4A90E2;
  }

  /* Define how SqPaymentForm iframes should look when they contain invalid values */
  .sq-input--error {
    border: 1px solid #E02F2F;
  }

  #sq-card-number {
    margin-bottom: 24px;
  }
</style>
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/active_merchant_square. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/machiyami/active_merchant_square/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveMerchantSquare project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/machiyami/active_merchant_square/blob/master/CODE_OF_CONDUCT.md).

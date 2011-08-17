# Saver

This gem lets you easily add text columns to your mongo mapper (only for now)
models. We use this gem to save logging information for one of our web apps. In
the future if the associations break, you'll still have a text version of the
data saved.

Clearly I'm **not** advocating ever deleting data, but we wanted to use this
feature so **if** something happens later on, we'd still have string versions of
the data.

## Example

Here is a simple class of a log item:

    class LogItem
      include Saver
      save_attributes :account, card
    end

If you want to use something other than `to_s` to generate the string you can
pass the method to use to the singular version of `save_attribute`:

    class LogItem
      include Saver
      save_attribute :account
      save_attribute :card, :method => :card_data
    end

Now when we save our model we get data like this:

    LogItem {
      :account_id => 1,
      :account_saver => 'Christopher Giroir',
      :card_id => 2,
      :card_saver => 'Card 45 with $50.00 on it'
    }

## Todo

* Add in tests

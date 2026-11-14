# 3. Add a form that delivers (minutes 58 to 68)

A form is only done when the email lands. DDEV catches every email the site sends in Mailpit, so you can prove delivery locally.

## Steps

1. In wp-admin, open **Contact**, then **Contact Forms**. Copy the shortcode for **Contact form 1**.
2. Open the **Register** page. Add a **Group** block below the buttons.
3. With the Group selected, open **Advanced** in the sidebar and set **HTML anchor** to `register-form`. The button from step 2 now scrolls here.
4. Inside the Group, add a **Shortcode** block and paste the shortcode.
5. Save, then open the page on the front end.

## Make the form trustworthy

- **Labels on every field.** Placeholders disappear as people type; labels don't.
- **Mark required fields** and only ask for what you need. Every extra field costs sign-ups.
- **Spam protection.** Akismet, a CAPTCHA or a honeypot field.
- **A clear success message.** Edit it under the form's **Messages** tab.

## Prove delivery

1. Submit the form with an obviously fake name.
2. Confirm the success message appears.
3. Run `ddev mailpit` and open the new message.

- [ ] Success message shown
- [ ] Email visible in Mailpit, with the values you typed

If no email arrives, that is your first real bug. Carry on to [4. Debug safely](04-debugging.md).

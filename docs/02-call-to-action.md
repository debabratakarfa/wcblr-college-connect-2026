# 2. Add a call to action (minutes 50 to 58)

A call to action is a promise. The label tells people exactly what happens when they click.

## Steps

1. In wp-admin, open **Pages**, then **Register**, in the block editor.
2. Insert a **Buttons** block above the content.
3. Type `Click here` as the label. Ask yourself: if this were the only thing on screen, where would it take you?
4. Change the label to **Register for updates**.
5. Link the button to `#register-form`. You will create that anchor in the next step.
6. Add a second button, **See the schedule**, and switch it to the **Outline** style. One primary action per section; everything else steps back.
7. Save and preview.

## Test it like a tester

- [ ] Preview at mobile width. The buttons wrap cleanly and stay easy to tap.
- [ ] Press **Tab** until the button has focus. You can see the focus ring.
- [ ] Text contrast is at least 4.5:1 for normal text (WCAG 2.1 AA). Check with your browser's DevTools or any contrast checker.
- [ ] The link goes where the label says it goes.

## Good and bad labels

| Avoid | Prefer |
| --- | --- |
| Click here | Register for updates |
| Submit | Send my question |
| Learn more | See the full schedule |

Next: [3. Add a form that delivers](03-form.md)

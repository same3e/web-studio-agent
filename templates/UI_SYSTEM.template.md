# UI system

## Approved visual language

- Style family:
- Style tags:
- Visual modifiers:
- Industry conversion patterns to preserve:
- Visual treatments to simplify or avoid:

## Tokens

- Keep site-wide color, font, radius, reset, focus, and reduced-motion tokens in `app/globals.css` only.

- Keep site-wide color, font, radius, reset, focus, and reduced-motion tokens in `app/globals.css` only.

## Typography

For hero typography, start directly with H1 unless the user has explicitly approved a pre-heading; see `knowledge/DESIGN_RULES.md`.

## Style file structure

- Use `app/header.module.css` for header-only layout, navigation, language switcher, and header CTA styles.
- Use `app/hero.module.css` for the complete first screen: hero layout, H1, supporting copy, CTAs, proof, media, and hero-only responsive rules.
- Keep page-shell or page-only residual UI in `app/page.module.css`. Do not place hero or header rules there.
- Keep CSS Modules so a page's `.hero` or `.header` cannot affect another page.

## Hero controls

- Put one clearly marked `HERO SETTINGS` block at the very top of `app/hero.module.css`.
- Provide exactly three locale profiles: EN, RU, and KA. Each profile exposes the same readable controls: title desktop/mobile size, title line-height, title letter-spacing, title-to-body gap, body size, body line-height, and body-to-buttons gap.
- Keep shared image controls alongside the profiles: desktop/mobile image height, radius, focal position, and mobile top gap. If the concept uses a decorative hero wordmark, expose its desktop/mobile top and left offsets there too.
- Derive the implementation styles from those variables. Do not add offset variables, duplicate locale overrides, or hidden typography adjustments later in the file.
- Keep responsive rules structural only (stacking, width, grid, visibility). A user should adjust visual hero values in the top settings block, not search media queries.

## Style file structure

- Use `app/header.module.css` for header-only layout, navigation, language switcher, and header CTA styles.
- Use `app/hero.module.css` for the complete first screen: hero layout, H1, supporting copy, CTAs, proof, media, and hero-only responsive rules.
- Keep page-shell or page-only residual UI in `app/page.module.css`. Do not place hero or header rules there.
- Keep CSS Modules so a page's `.hero` or `.header` cannot affect another page.

## Hero controls

- Put one clearly marked `HERO SETTINGS` block at the very top of `app/hero.module.css`.
- Provide exactly three locale profiles: EN, RU, and KA. Each profile exposes the same readable controls: title desktop/mobile size, title line-height, title letter-spacing, title-to-body gap, body size, body line-height, and body-to-buttons gap.
- Keep shared image controls alongside the profiles: desktop/mobile image height, radius, focal position, and mobile top gap.
- Derive the implementation styles from those variables. Do not add offset variables, duplicate locale overrides, or hidden typography adjustments later in the file.
- Keep responsive rules structural only (stacking, width, grid, visibility). A user should adjust visual hero values in the top settings block, not search media queries.

## Components and states

## Motion and reduced motion

<?php
/**
 * Plugin Name: WordCamp Bengaluru Demo: Slow CTA
 * Description: Workshop demo only. Appends a CTA to single posts using a deliberate N+1 query loop so XHGui has something real to find. Add ?fast=1 to the URL to see the cached version.
 * Version:     1.0.0
 * Author:      Debabrata Karfa
 *
 * Install: copy to wp-content/mu-plugins/. Never deploy to production.
 */

defined( 'ABSPATH' ) || exit;

add_filter( 'the_content', 'wcblr_demo_append_cta', 20 );

/**
 * Append the CTA to single post content.
 *
 * @param string $content Post content.
 * @return string
 */
function wcblr_demo_append_cta( $content ) {
	if ( ! is_singular( 'post' ) ) {
		return $content;
	}

	// phpcs:ignore WordPress.Security.NonceVerification.Recommended -- read-only demo toggle.
	$use_cache = isset( $_GET['fast'] );
	$html      = $use_cache ? get_transient( 'wcblr_demo_cta' ) : false;

	if ( false === $html ) {
		$html = wcblr_demo_build_cta();

		if ( $use_cache ) {
			set_transient( 'wcblr_demo_cta', $html, HOUR_IN_SECONDS );
		}
	}

	return $content . $html;
}

/**
 * Build the CTA markup the slow way.
 *
 * The loop runs one uncached query per iteration: the classic N+1 pattern
 * you will spot in XHGui as a high call count on WP_Query and wpdb::query.
 *
 * 1000 loops is about 2,000 queries and ~0.8s on a small DDEV site, enough
 * to stand out against WordPress's own ~0.2s baseline. Override with
 * define( 'WCBLR_DEMO_LOOPS', 500 ); in wp-config.php if the room's laptop is slower.
 *
 * @return string
 */
function wcblr_demo_build_cta() {
	$titles = array();

	$loops = defined( 'WCBLR_DEMO_LOOPS' ) ? (int) WCBLR_DEMO_LOOPS : 1000;

	for ( $i = 0; $i < $loops; $i++ ) {
		$query = new WP_Query(
			array(
				'post_type'      => 'post',
				'posts_per_page' => 3,
				'orderby'        => 'rand',
				'cache_results'  => false,
				'no_found_rows'  => false,
			)
		);

		foreach ( $query->posts as $post ) {
			$titles[ $post->ID ] = get_the_title( $post );
		}
	}

	$titles = array_slice( $titles, 0, 3, true );
	$items  = '';

	foreach ( $titles as $id => $title ) {
		$items .= sprintf( '<li><a href="%s">%s</a></li>', esc_url( get_permalink( $id ) ), esc_html( $title ) );
	}

	return sprintf(
		'<aside class="wcblr-demo-cta"><h3>%1$s</h3><ul>%2$s</ul>'
		. '<div class="wp-block-buttons"><div class="wp-block-button">'
		. '<a class="wp-block-button__link wp-element-button" href="%3$s">%4$s</a>'
		. '</div></div></aside>',
		esc_html__( 'Keep reading', 'wcblr-demo' ),
		$items,
		esc_url( home_url( '/register/' ) ),
		esc_html__( 'Register for updates', 'wcblr-demo' )
	);
}

<?php
/**
 * Plugin Name:       Post Format Block
 * Description:       Adds a Post Format Block as a variation of the core/post-terms block. 
 * Requires at least: 5.9-alpha
 * Requires PHP:      7.0
 * Version:           0.1.0
 * Author:            Aaron Jorbin 
 * License:           GPL-2.0-or-later
 * License URI:       https://www.gnu.org/licenses/gpl-2.0.html
 * Text Domain:       post-format-block
 *
 * @package           create-block
 */

/**
 * Register our block
 *
 * The block type we register is actually a variant, but this allows it to show up as a "block" plugin.
 */
function jorbin_post_format_block_block_init() {
	register_block_type( __DIR__ );
}

add_action( 'init', 'jorbin_post_format_block_block_init' );

/**
 * Make the post formats avilable in the REST API
 */
function jorbin_post_format_block_taxonomy_args( $args, $taxonomy_name ) {
    if ( 'post_format' === $taxonomy_name ) {
        $args['show_in_rest'] = true;
	}
	return $args;
}
add_filter( 'register_taxonomy_args', 'jorbin_post_format_block_taxonomy_args', 10, 2 );

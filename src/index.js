// Block Registration Function
import { registerBlockVariation } from '@wordpress/blocks';

// Internationalization
import { __ } from '@wordpress/i18n';

// Icon
import { postCategories as icon } from '@wordpress/icons';

// https://github.com/WordPress/gutenberg/blob/trunk/packages/block-library/src/post-terms/variations.js
const variation = {
	name: 'post_format',
	title: __('Post Format'),
	description: __("Display a post's format"),
	icon,
	isDefault: true,
	attributes: { term: 'post_format' },
	isActive: (blockAttributes) => blockAttributes.term === 'post_format',
};

registerBlockVariation( 'core/post-terms', variation );

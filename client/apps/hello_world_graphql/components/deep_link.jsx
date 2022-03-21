import _ from 'lodash';
import React from 'react';
import gql from 'graphql-tag';
import PropTypes from 'prop-types';
import ContentItemSelectionForm from 'atomic-canvas/libs/lti/components/content_item_selection_form';
import { useMutation } from '@apollo/client';

export default function DeepLink(props) {

  const {
    deepLinkSettings,
  } = props;

  const CREATE_DEEP_LINK_JWT = gql`
    mutation createDeepLinkJwt($type: String!) {
      createLtiDeepLinkJwt(type: $type) {
        deepLinkJwt
      }
    }
  `;

  const [createLtiDeepLinkJwt, { loading, error, data }] = useMutation(CREATE_DEEP_LINK_JWT);

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  if (data && !_.isEmpty(data.createLtiDeepLinkJwt.deepLinkJwt)) {
    // ContentItemSelectionForm accepts launchData which is
    // an object of key value pairs that will be posted back to
    // the platform. contentItemReturnURL is the url to post
    // back to.
    return (
      <ContentItemSelectionForm
        launchData={{ JWT: data.createLtiDeepLinkJwt.deepLinkJwt }}
        contentItemReturnURL={deepLinkSettings.deep_link_return_url}
      />
    );
  }

  return (
    <div>
      <button
        type="submit"
        onClick={() => {
          createLtiDeepLinkJwt({
            variables: {
              type: 'html',
            },
          });
        }}
      >
        Save
      </button>
    </div>
  );

}

// Extracted from IMS documentation
// https://www.imsglobal.org/spec/lti-dl/v2p0#deep-linking-settings
DeepLink.propTypes = {
  deepLinkSettings: PropTypes.shape({
    // Platform url to post the deep link to
    deep_link_return_url: PropTypes.string.isRequired,
    // LTI type. One of: ["link", "file", "html", "ltiResourceLink", "image"]
    accept_types: PropTypes.arrayOf(PropTypes.string).isRequired,
    // An array of document targets supported. e.g. ['iframe', 'window', 'embed']
    accept_presentation_document_targets: PropTypes.arrayOf(PropTypes.string).isRequired,
    // Media types the platform accepts. Only applies to File types. e.g. "image/*,text/html".
    accept_media_types: PropTypes.string,
    // Whether the platform allows multiple content items to be submitted in a single response
    accept_multiple: PropTypes.bool,
    // Whether any content items returned by the tool would be automatically persisted without
    // any option for the user to cancel the operation. The default is false.
    auto_create: PropTypes.bool,
    // Default text to be used as the title or alt text for the content item returned by the tool.
    // This value is normally short in length, for example, suitable for use as a heading.
    title: PropTypes.string,
    // Default text to be used as the visible text for the content item returned by the tool.
    // If no text is returned by the tool, the platform may use the value of the title parameter
    // instead (if any). This value may be a long description of the content item.
    text: PropTypes.string,
    // An opaque value which must be returned by the tool in its response if it was passed in
    // on the request
    data: PropTypes.string,
  }),
};

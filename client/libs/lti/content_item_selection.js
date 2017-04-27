// This file contains helper functions for generating a content item response.
// These functions should be used as examples for generating the json required
// to respond to a content item selection request.
// See the specification linked to below for more details.
//
// Content Item specification
// https://www.imsglobal.org/specs/lticiv1p0/specification
//
// Example of 'content_items' json that needs to be sent to the tool consumer
// content_items: {
//  "@context": "http://purl.imsglobal.org/ctx/lti/v1/ContentItem",
//  "@graph": [
//    {
//      "@type": "LtiLinkItem",
//      "@id": "http://example.com/messages/launch",
//      "url": "http://example.com/messages/launch",
//      "title": "test",
//      "text": "text",
//      "mediaType": "application/vnd.ims.lti.v1.ltilink",
//      "placementAdvice": {
//        "presentationDocumentTarget": "frame"
//      }
//    }
//  ]
// }


// Wraps an array of graph items in the ContentItem hash
export function contentItems(graph) {
  return {
    '@context':  'http://purl.imsglobal.org/ctx/lti/v1/ContentItem',
    '@graph': graph,
  };
}

// Embeds html
export function embedHtml(html) {
  return [
    {
      '@type': 'ContentItem',
      mediaType: 'text/html',
      text: html,
      placementAdvice: {
        presentationDocumentTarget: 'embed',
      },
    },
  ];
}

// Adds an lti launch link
export function ltiLaunch(name, launchURL) {
  return [
    {
      '@type': 'LtiLinkItem',
      mediaType: 'application/vnd.ims.lti.v1.ltilink',
      url: launchURL,
      title: name,
    },
    {
      '@type': 'LtiLinkItem',
      mediaType: 'application/vnd.ims.lti.v1.ltilink',
      url: launchURL,
      title: name,
      text: name,
      lineItem: {
        '@type': 'LineItem',
        label: name,
        reportingMethod: 'res:totalScore',
        maximumScore: 10,
        scoreConstraints: {
          '@type': 'NumericLimits',
          normalMaximum: 10,
          totalMaximum: 10,
        },
      },
    },
  ];
}

// Adds an iframe to the page as html
export function embedIframe(iframeURL) {
  const iframe = `<iframe style="width: 100%; height: 500px;" src="${iframeURL}"></iframe>`;
  return [
    {
      '@type': 'ContentItem',
      mediaType: 'text/html',
      text: iframe,
      placementAdvice: {
        presentationDocumentTarget: 'embed',
      },
    },
  ];
}

// Adds an iframe with an LTI launch
export function embedLtiIframe(iframeURL) {
  return [
    {
      '@type': 'LtiLinkItem',
      mediaType: 'application/vnd.ims.lti.v1.ltilink',
      text: 'iframe launched as lti',
      url: iframeURL,
      placementAdvice: {
        presentationDocumentTarget: 'iframe',
      },
    },
  ];
}


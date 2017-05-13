// This file contains helper functions for generating a content item response.
// These functions should be used as examples for generating the json required
// to respond to a content item selection request.
// See the specification linked to below for more details.
//
// Content Item specification:
// https://www.imsglobal.org/specs/lticiv1p0/specification
//
// Example content item responses can be found here:
// https://www.imsglobal.org/specs/lticiv1p0/specification-3
//

// Wraps an array of graph items in the ContentItem hash
export function contentItems(graph) {
  return {
    '@context':  'http://purl.imsglobal.org/ctx/lti/v1/ContentItem',
    '@graph': graph,
  };
}

// Embeds html
export function embedHtml(html) {
  return contentItems([
    {
      '@type': 'ContentItem',
      mediaType: 'text/html',
      text: html,
      placementAdvice: {
        presentationDocumentTarget: 'embed',
      },
    },
  ]);
}

// Embed multiple html items
export function embedMultipleHtml(html1, html2) {
  return contentItems([
    {
      '@type': 'ContentItem',
      mediaType: 'text/html',
      text: html1,
      placementAdvice: {
        presentationDocumentTarget: 'embed',
      },
    },
    {
      '@type': 'ContentItem',
      mediaType: 'text/html',
      text: html2,
      placementAdvice: {
        presentationDocumentTarget: 'embed',
      },
    },
  ]);
}

// Embeds an png image
export function embedImage(text, title, width, height, url) {
  return contentItems([
    { '@type': 'FileItem',
      url,
      mediaType: 'image/png',
      text,
      title,
      placementAdvice: {
        displayWidth: width,
        displayHeight: height,
        presentationDocumentTarget: 'embed'
      }
    }
  ]);
}

// Embeds a thumbnail link as html
export function imageLink(title, width, height, url) {
  return contentItems([
    {
      '@type': 'ContentItem',
      url,
      mediaType: 'text/html',
      thumbnail: {
        '@id': 'http://developers.imsglobal.org/images/imscertifiedsm.png',
        width,
        height
      },
      title,
      placementAdvice: {
        presentationDocumentTarget: 'window',
        windowTarget: '_blank'
      }
    }
  ]);
}

// Adds an lti launch link
export function ltiLaunch(name, launchURL) {
  return contentItems([
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
          totalMaximum: 10
        }
      }
    }
  ]);
}

// Adds an iframe to the page as html
export function embedIframe(iframeURL) {
  const iframe = `<iframe style="width: 100%; height: 500px;" src="${iframeURL}"></iframe>`;
  return contentItems([
    {
      '@type': 'ContentItem',
      mediaType: 'text/html',
      text: iframe,
      placementAdvice: {
        presentationDocumentTarget: 'embed',
      },
    },
  ]);
}

// Adds an iframe with an LTI launch
export function embedLtiIframe(url, displayWidth, displayHeight) {
  return contentItems([
    {
      '@type': 'LtiLinkItem',
      mediaType: 'application/vnd.ims.lti.v1.ltilink',
      url,
      placementAdvice: {
        displayWidth,
        displayHeight,
        presentationDocumentTarget: 'iframe',
      },
    },
  ]);
}

// Adds an iframe with an LTI launch and grade write back
// LineItem specification:
// https://www.imsglobal.org/lti/model/uml/purl.imsglobal.org/vocab/lis/v2/outcomes/index.html#LineItem
export function embedLtiIframeWriteBack(label, url) {
  return {
    '@context': [
      'http://purl.imsglobal.org/ctx/lti/v1/ContentItem',
      {
        lineItem: 'http://purl.imsglobal.org/ctx/lis/v2/LineItem',
        res: 'http://purl.imsglobal.org/ctx/lis/v2p1/Result#'
      }
    ],
    '@graph': [
      {
        '@type': 'LtiLinkItem',
        mediaType: 'application/vnd.ims.lti.v1.ltilink',
        title: label,
        url,
        lineItem: {
          '@type': 'LineItem',
          label,
          reportingMethod: 'res:totalScore',
          scoreConstraints: {
            '@type': 'NumericLimits',
            normalMaximum: 10,
            extraCreditMaximum: 0,
            totalMaximum: 10,
          },
        },
        placementAdvice: {
          presentationDocumentTarget: 'iframe',
        },
      },
    ],
  };
}

import React from 'react';
import TestRenderer from 'react-test-renderer';
import { SiteModal } from './modal';

describe('site modal', () => {
  let result;
  let props;

  const url = 'bfcoder.com';

  beforeEach(() => {
    props = {
      isOpen: true,
      closeModal: () => {},
      site: {
        id: 1,
        url
      },
      createSite: () => {},
      updateSite: () => {},
      settings: {
        lti_key: '',
        canvas_callback_url: '',
      },
    };
    result = TestRenderer.create(<SiteModal {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});

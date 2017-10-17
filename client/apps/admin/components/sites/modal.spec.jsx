import React from 'react';
import { shallow } from 'enzyme';
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
    result = shallow(<SiteModal {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});

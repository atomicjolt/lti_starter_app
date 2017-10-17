import React from 'react';
import { shallow } from 'enzyme';
import { SiteModal } from './delete_modal';

describe('site modal', () => {
  let result;
  let props;

  const url = 'bfcoder.com';

  beforeEach(() => {
    props = {
      isOpen: true,
      closeModal: () => {},
      deleteSite: () => {},
      site: {
        id: 1,
        url
      },
    };
    result = shallow(<SiteModal {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the setting of state', () => {
    expect(result.instance().state.site).toEqual(props.site);
  });
});

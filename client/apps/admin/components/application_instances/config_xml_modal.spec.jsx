import React from 'react';
import { shallow } from 'enzyme';
import ConfigXmlModal from './config_xml_modal';

describe('config xml modal', () => {
  let result;
  let props;
  let closed;

  beforeEach(() => {
    closed = false;
    props = {
      isOpen: true,
      closeModal: () => { closed = true; },
      application: {
        id: 1,
        name: 'bfcoder',
      },
      applicationInstance: {
        id: 1,
        lti_key: 'something-special',
        lti_secret: '12345',
        lti_config_xml: 'IMA XML',
      },
    };
    result = shallow(<ConfigXmlModal {...props} />);
  });

  // TODO: find a way to reach into the ReactModal
  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the closeModal function', () => {
    expect(closed).toBeFalsy();
    result.find('button').simulate('click');
    expect(closed).toBeTruthy();
  });
});

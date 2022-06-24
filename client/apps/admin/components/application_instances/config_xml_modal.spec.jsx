import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer from 'react-test-renderer';
import ConfigXmlModal from './config_xml_modal';

describe('config xml modal', () => {
  let result;
  let instance;
  let closed;

  const isOpen = true;
  const closeModal = () => { closed = true; };
  const application = {
    id: 1,
    name: 'bfcoder'
  };
  const applicationInstance = {
    id: 1,
    lti_key: 'something-special',
    lti_secret: '12345',
    lti_config_xml: 'IMA XML',
  };

  // https://medium.com/@amanverma.dev/mocking-create-portal-to-utilize-react-test-renderer-in-writing-snapshot-uts-c49773c88acd
  beforeAll(() => {
    ReactDOM.createPortal = jest.fn((element) => element);
  });

  afterEach(() => {
    ReactDOM.createPortal.mockClear();
  });

  beforeEach(() => {
    closed = false;
    result = TestRenderer.create(
      <ConfigXmlModal
        isOpen={isOpen}
        closeModal={closeModal}
        application={application}
        applicationInstance={applicationInstance}
      />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the closeModal function', () => {
    expect(closed).toBeFalsy();
    instance.findByType('button').props.onClick();
    expect(closed).toBeTruthy();
  });
});

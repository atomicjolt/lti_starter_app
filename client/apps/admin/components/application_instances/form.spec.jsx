import React from 'react';
import TestRenderer from 'react-test-renderer';
import Form from './form';

describe('application instance form', () => {
  let result;
  let instance;
  let props;
  let modalClosed = false;
  let saved;

  beforeEach(() => {
    saved = false;
    props = {
      onChange: () => {},
      closeModal: () => { modalClosed = true; },
      save: () => { saved = true; },
      newSite: () => {},
      site_id: 'foo',
      sites: {},
      config: '{ "foo": "bar" }',
      ltiConfigParseError: '',
    };
    result = TestRenderer.create(<Form {...props} />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the close modal event', () => {
    expect(modalClosed).toBeFalsy();
    instance.findAllByType('button').find(b => b.children[0] === 'Cancel').props.onClick();
    expect(modalClosed).toBeTruthy();
  });

  it('handles the save event', () => {
    expect(saved).toBeFalsy();
    instance.findAllByType('button').find(b => b.children[0] === 'Save').props.onClick();
    expect(saved).toBeTruthy();
  });
});

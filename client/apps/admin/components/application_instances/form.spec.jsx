import React from 'react';
import TestRenderer from 'react-test-renderer';
import Form from './form';

describe('application instance form', () => {
  let result;
  let instance;
  let modalClosed = false;
  let saved;

  const onChange = () => {};
  const closeModal = () => { modalClosed = true; };
  const save = () => { saved = true; };
  const newSite = () => {};
  const site_id = 'foo';
  const sites = {};
  const config = '{ "foo": "bar" }';
  const ltiConfigParseError = '';

  beforeEach(() => {
    saved = false;
    result = TestRenderer.create(<Form
      onChange={onChange}
      closeModal={closeModal}
      save={save}
      newSite={newSite}
      site_id={site_id}
      sites={sites}
      config={config}
      ltiConfigParseError={ltiConfigParseError}
    />);
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

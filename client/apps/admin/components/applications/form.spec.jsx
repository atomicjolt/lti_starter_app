import React from 'react';
import TestRenderer from 'react-test-renderer';
import Form from './form';
import Textarea from '../common/textarea';

describe('applications form', () => {
  let result;
  let instance;
  let props;
  let didSave;
  let didClose;

  beforeEach(() => {
    didClose = false;
    didSave = false;
    props = {
      onChange    : () => {},
      closeModal  : () => { didClose = true; },
      save        : () => { didSave = true; },
      description : 'SPEC_DESCRIPTION',
      defaultConfig: '{ "foo": "bar" }',
      configParseError: '',
    };

    result = TestRenderer.create(<Form {...props} />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('did save', () => {
    expect(didSave).toBeFalsy();
    const buttons = instance.findAllByType('button');
    const button = buttons.find(b => b.children[0] === 'Save');
    button.props.onClick();
    expect(didSave).toBeTruthy();
  });

  it('close modal', () => {
    expect(didClose).toBeFalsy();
    const buttons = instance.findAllByType('button');
    const button = buttons.find(b => b.children[0] === 'Cancel');
    button.props.onClick();
    expect(didClose).toBeTruthy();
  });

  it('renders default config', () => {
    const inputs = instance.findAllByType('input');
    const input = inputs.find(b => b.props.value === 'SPEC_DESCRIPTION');
    expect(input).toBeDefined();
  });

  it('renders the warning', () => {
    const textA = instance.findAllByType(Textarea)[0];
    expect(textA.props.warning).toBe(null);
    props.configParseError = 'This is a warning';
    result = TestRenderer.create(<Form {...props} />);
    expect.stringContaining(props.configParseError);
  });
});

import React from 'react';
import { shallow } from 'enzyme';
import Form from './form';
import Textarea from '../common/textarea';

describe('applications form', () => {
  let result;
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

    result = shallow(<Form {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('did save', () => {
    expect(didSave).toBeFalsy();
    result.find('.c-btn--yellow').simulate('click');
    expect(didSave).toBeTruthy();
  });

  it('close modal', () => {
    expect(didClose).toBeFalsy();
    result.find('.c-btn--gray--large').simulate('click');
    expect(didClose).toBeTruthy();
  });

  it('renders default config', () => {
    const input = result.find('input');
    expect(input).toBeDefined();
    expect(input.props().value).toEqual('SPEC_DESCRIPTION');
  });

  it('renders the warning', () => {
    const textA = result.find(Textarea).first();
    expect(textA.props().warning).toBe(null);
    props.configParseError = 'This is a warning';
    result = shallow(<Form {...props} />);
    expect.stringContaining(props.configParseError);
  });
});

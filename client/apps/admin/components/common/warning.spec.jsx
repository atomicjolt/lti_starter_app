import React from 'react';
import { shallow } from 'enzyme';
import Warning from './warning';

describe('warning', () => {
  let result;
  let props;

  beforeEach(() => {
    props = {
      text: 'bfcoder was here',
    };
    result = shallow(<Warning {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('renders the warning', () => {
    const warning = result.find('div');
    expect(warning.props().children[1]).toContain(props.text);
  });
});

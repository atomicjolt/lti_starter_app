import React from 'react';
import { shallow } from 'enzyme';
import List from './list';

describe('sites list', () => {
  let result;
  let props;

  const sites = {
    1: {
      id: 1,
      url: 'bfcoder.com'
    },

    2: {
      id: 2,
      url: 'atomicjolt.com'
    }
  };

  beforeEach(() => {
    props = {
      sites,
      deleteSite: () => {},
    };
    result = shallow(<List {...props} />);
  });

  it('renders the list with header values', () => {
    const thead = result.find('thead');
    expect(thead.props().children).toEqual(
      <tr>
<th><span>URL</span></th>
<th><span>SETTINGS</span></th>
<th><span>DELETE</span></th>
</tr>
    );
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});

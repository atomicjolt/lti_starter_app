import React from 'react';
import { shallow } from 'enzyme';
import { Home } from './home';

jest.mock('../libs/assets.js');

describe('home', () => {
  it('renders the home component', () => {
    const props = {
      canvasRequest: () => {},
      settings: {
        canvas_auth_required: false,
      },
    };
    const result = shallow(<Home {...props} />);
    expect(result).toMatchSnapshot();
  });

});

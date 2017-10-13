import React from 'react';
import { shallow } from 'enzyme';
import Pagination from './pagination';

describe('lti installs pagination', () => {
  let result;
  let props;

  beforeEach(() => {
    props = {
      courses: [{ name: 'name', id: 1 }, { name: 'name', id: 2 }],
      pageSize: 1,
      setPage: () => {},
      pageCount: 21,
      currentPage: 2
    };
    result = shallow(<Pagination {...props} />);
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('renders the form not null', () => {
    expect(result).not.toBeNull();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});

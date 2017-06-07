import React from 'react';
import { shallow } from 'enzyme';
import ContentItemSelectionForm from './content_item_selection_form';

describe('Content Item Selection Form', () => {
  let result;
  let props;
  it('matches the snapshot', () => {
    props = {
      launchData: {},
      contentItemReturnURL: 'http://www.example.com',
    };
    result = shallow(<ContentItemSelectionForm {...props} />);
    expect(result).toMatchSnapshot();
  });
});

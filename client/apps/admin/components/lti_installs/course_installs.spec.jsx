import React from 'react';
import { shallow } from 'enzyme';
import CourseInstalls from './course_installs';

describe('lti installs course install', () => {
  let result;
  let changed = false;
  let props;
  const courseId = 123;

  beforeEach(() => {
    props = {
      applicationInstance: {
        name: 'application_name',
        lti_key: 'lti_key',
        lti_secret: 'lti_secret',
        lti_config_xml: 'lti_config_xml',
      },
      canvasRequest: () => {},
      onlyShowInstalledChanged: () => { changed = true; },
      loadingCourses: {
        courseName: 'name',
        courseId: 'id',
      },
      courses: [],
      installedTool: {
        id: 12
      },
      courseName: 'courseName',
      courseId,
    };
    result = shallow(<CourseInstalls {...props} />);
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

  it('renders buttons', () => {
    const courseName = result.find('span');
    expect(courseName.props().children).toBe('Course Name');
  });

  it('handles the onChange for input', () => {
    expect(changed).toBeFalsy();
    const input = result.find('input');
    input.simulate('change');
    expect(changed).toBeTruthy();
  });
});

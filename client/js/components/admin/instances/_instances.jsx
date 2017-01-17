import React          from 'react';
import InstanceHeader from './instance_header';
import Search         from './search';
import InstanceList   from './instance_list';

export default class Instances extends React.Component {

  render() {
    return (
      <div className="o-contain o-contain--full">
        <InstanceHeader />
        <Search />
        <InstanceList />
      </div>
    );
  }
}

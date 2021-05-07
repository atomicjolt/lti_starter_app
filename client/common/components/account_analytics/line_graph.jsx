import React from 'react';
import PropTypes from 'prop-types';
import { Line } from 'react-chartjs-2';

export default function LineGraph(props) {
  const { data, options, label, plugins } = props;

  return (
    <div className="aj-flex">
      <figure role="group" className="analytics-graph">
        <div className="aj-account-graph-background" />
        <div
          className="aj-account-graph"
          role="img"
          aria-label={label}
        >
          <Line data={data} options={options} plugins={plugins} />
        </div>
      </figure>
    </div>
  );
}

LineGraph.propTypes = {
  data: PropTypes.shape({}),
  options: PropTypes.shape({}),
  label: PropTypes.string,
  plugins: PropTypes.array,
};

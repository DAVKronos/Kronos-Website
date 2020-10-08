import React from 'react';

export default function withData(WrappedComponent, dataFunction) {
    return class extends React.Component {
        constructor(props) {
            super(props);
            this.state = {
                data: null,
                loading: true
            };
        }

        componentDidMount() {
            dataFunction(this.props).then(data => {
                this.setState({data, loading: false})
            })
        }

        render() {
            return <WrappedComponent {...this.state} {...this.props} />;
        }
    };
}
import React from 'react'
import { Switch, Route } from 'react-router-dom'
import Results from './Results'
import Records from './Records'

const ResultsRouter = () => {
  return (
    <Switch>
      <Route exact path='/results' component={Results} />
      <Route path='/results/records' component={Records} />
    </Switch>
  )
}

export default ResultsRouter

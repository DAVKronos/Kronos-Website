import React, {useState, useContext} from "react";
import {Button, Col, Row, Image, Form} from 'react-bootstrap';
import {getAPIHostUrl} from "../../utils/rest-helper";
import {format} from '../../utils/date-format';
import {useQuery, useQueryCache} from "react-query";
import {
    approveNewsItem,
    createNewsItemComment,
    getNewsItem,
    getNewsItemComments,
    removeNewsItem,
    removeNewsItemComment
} from "./queries";
import DefaultSpinner from "../Generic/Spinner";
import {Can} from "../../utils/auth-helper";
import {useTranslation} from "react-i18next";
import {Link, useHistory} from "react-router-dom";
import ReactMarkdown from 'react-markdown';
import {getUser} from "../Users/queries";
import {subject} from "@casl/ability";
import {authContext} from "../../utils/AuthContext";

const NewsItemComments = ({newsItemId}) => {
    const { isLoading, isError, data: comments, error } = useQuery(['comments',newsItemId], getNewsItemComments);
    
    return <div>
        {comments && comments.map(comment => {
            return <Comment key={comment.id} comment={comment}/>;
        })
        }
        <Can I={'create'} a={"Comment"}>
            {!isLoading && <NewComment newsItemId={newsItemId}/>}
        </Can>
    </div>;
}

const NewComment = ({newsItemId}) => {
    const { user } = useContext(authContext);
    const [loading, setLoading] = useState(false)
    const [text, setText] = useState('')
    const {t} = useTranslation('generic');
    const queryCache = useQueryCache()

    const createComment = () => {
        setLoading(true);
        const comment = {commentable_id: newsItemId, commentable_type: "Newsitem", commenttext: text}
        createNewsItemComment(newsItemId, comment).then(() => {
            queryCache.invalidateQueries(['comments', comment.commentable_id]);
        }).finally(() => {
            setLoading(false);
        })
    }

    return <Row style={{borderTop: "1px solid #eee", paddingTop: 10, display: 'flex', alignItems: 'center'}}>
        <Col md={2} style={{display: "flex", flexDirection: "column", alignItems: "center"}}>
            {user && <Image src={user.avatar_url_thumb} roundedCircle />}
            {user && <h5>{user.name}</h5>}
        </Col>
        <Col md={8} style={{display: 'flex', alignItems: 'center'}}>
            <Form.Control as="textarea" value={text} onChange={e => setText(e.target.value)} placeholder={t('comment')} />
        </Col>
        <Col md={2}>

                <Button variant='success' onClick={createComment} disabled={loading}>
                    {loading && <DefaultSpinner inline/>}
                    {!loading && t('send')}
                </Button>

        </Col>
    </Row>
}

const Comment = ({comment}) => {
    const { isLoading, isError, data: user, error } = useQuery(['users',comment.user_id], getUser);
    const {t} = useTranslation('generic');
    const queryCache = useQueryCache()
    const onClickRemove = () => {
        removeNewsItemComment(comment.commentable_id, comment.id).then(() => {
            queryCache.invalidateQueries(['comments', comment.commentable_id]);
        });
    }
    return <Row style={{borderTop: "1px solid #eee", paddingTop: 10, display: 'flex', alignItems: 'center'}}>
        <Col md={2} style={{display: "flex", flexDirection: "column", alignItems: "center"}}>
            {isLoading && <DefaultSpinner/>}
            {user && <Image src={user.avatar_url_thumb} roundedCircle />}
            {user && <h5>{user.name}</h5>}
        </Col>
        <Col md={8} style={{display: 'flex', alignItems: 'center'}}>
            {comment.commenttext}
        </Col>
        <Col md={2}>
            <Can I={'delete'} this={subject('Comment', comment)}>
                <Button variant='danger' onClick={onClickRemove}>{t('remove')}</Button>
            </Can>
        </Col>
    </Row>
}



function NewsItem(props) {
    const {t, i18n} = useTranslation('generic');
    const history = useHistory();
    const id = props.match.params.id;
    const { isLoading, isError, data, error } = useQuery(['newsitems',id], getNewsItem);

    if (isLoading) {
        return <DefaultSpinner/>;
    }

    let item = data;
    if (!data) {
        return null;
    }

    const onClickRemove = () => {
        removeNewsItem(id).then(() => {
            history.back();
        });
    }

    const onClickApprove = () => {
        approveNewsItem(id).then(() => {
            history.push('/admin/approve-news');
        });
    }

    const title = i18n.language === 'nl' ? item.title : item.title_en;
    const news = i18n.language === 'nl' ? item.news : item.news_en;

    return  <React.Fragment>
        <Row>
            <Col md={{span: 8, offset: 2}}>
                <h1>{title}</h1>
                <p>{format(item.created_at, 'PPP p', i18n.language)} | {item.user.name}</p>
            </Col>
        </Row>
        <Row>
            <Col md={{span: 8, offset: 2}}>
                <img src={getAPIHostUrl(item.articlephoto_url_carrousel)} alt={item.title}/>
                <ReactMarkdown source={news}/>
                <Can I='read' a={'Comment'}>
                    {item && <NewsItemComments newsItemId={item.id} />}
                </Can>
            </Col>
            <Col md={2}>
                {!item.agreed && <Can I="manage" subject={"all"}>
                    <Button variant='success' onClick={onClickApprove}>{t('approve')}</Button>
                </Can>}
                <Can I="update" a={"Newsitem"}>
                    <Button variant='warning' as={Link} to={`/newsitems/${id}/edit`}>{t('edit')}</Button>
                </Can>
                <Can I="delete" a={"Newsitem"}>
                    <Button variant='danger' onClick={onClickRemove}>{t('remove')}</Button>
                </Can>
            </Col>
        </Row>
    </React.Fragment>
}

export default NewsItem;
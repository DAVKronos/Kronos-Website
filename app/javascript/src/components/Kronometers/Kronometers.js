import React from "react";
import {Row, Col, Card, Button} from 'react-bootstrap';
import {Link} from 'react-router-dom';
import {getKronometersByFolder, getKronometers, getFolders, getFolderById} from "./queries";
import {useQuery} from "react-query";
import {useTranslation} from "react-i18next";
import DefaultSpinner from "../Generic/Spinner";
import {BsFolder, BsArrowUp} from 'react-icons/bs';


const Kronometers = (props) => {
    const folderId = props.match && props.match.params && props.match.params.folder_id;
    let folderName, folders, isFolderLoading, kronometers, isKronometerLoading, parentId;
    const {t} = useTranslation('kronometerPage');
    if (!folderId) {
        const folderQuery = useQuery('folders', getFolders);
        const kronometerQuery = useQuery('kronometers', getKronometers)
        isFolderLoading = folderQuery.isLoading;
        folderName = t('mainFolder');
        folders = folderQuery.data;
        kronometers = kronometerQuery.data;
        isKronometerLoading = kronometerQuery.isLoading;
    } else {
        const folderQuery = useQuery(['folders',folderId], getFolderById);
        const kronometerQuery = useQuery(['kronometers', folderId], getKronometersByFolder)
        isFolderLoading = folderQuery.isLoading;
        if (folderQuery.data) {
            folderName = folderQuery.data.name;
            folders = folderQuery.data.folders;
            parentId = folderQuery.data.folder_id;
        }

        kronometers = kronometerQuery.data;
        isKronometerLoading = kronometerQuery.isLoading;
    }

    const parentUrl = parentId ? `/kronometers/${parentId}` : '/kronometers';
    const parentButton = folderId &&  <Button as={Link} to={parentUrl} size="sm"><BsArrowUp /></Button>;

    return <React.Fragment>
        <Row>
            <Col>
                 <h1>{folderName}</h1>
            </Col>

        </Row>
        <Row>
            <Col>
                <h2>{parentButton} {t('subfolders')}</h2>

            </Col>
        </Row>
        <Row>
            {isFolderLoading && <DefaultSpinner/>}
            {folders && folders.map((folder) => {
                return <Col key={folder.id} md={3} sm={4}>
                    <Card>
                        <Card.Body>
                            <Card.Title><Link to={`/kronometers/${folder.id}`}>
                                <BsFolder/> {folder.name}
                            </Link></Card.Title>
                        </Card.Body>

                    </Card>
                </Col>;
            })}
        </Row>
        <Row>
            <Col>
                <h2>{t('documents')}</h2>

            </Col>
        </Row>
        <Row>
            {isKronometerLoading && <DefaultSpinner/>}
            {kronometers && kronometers.map((kronometer) => {
                return <Col key={kronometer.id} md={3} sm={4}>
                    <Card>
                        <a target="_blank" href={kronometer.url_original}>
                        <Card.Img src={kronometer.url_thumb} />
                        </a>
                        <Card.Body>
                            <Card.Title>{kronometer.name}</Card.Title>
                            <Card.Subtitle className="mb-2 text-muted">{kronometer.date}</Card.Subtitle>
                        </Card.Body>
                    </Card>
                </Col>;
            })}
        </Row>
    </React.Fragment>;
}

export default Kronometers
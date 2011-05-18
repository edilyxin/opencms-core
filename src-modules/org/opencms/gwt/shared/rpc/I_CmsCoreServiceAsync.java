/*
 * File   : $Source: /alkacon/cvs/opencms/src-modules/org/opencms/gwt/shared/rpc/Attic/I_CmsCoreServiceAsync.java,v $
 * Date   : $Date: 2011/05/18 13:25:57 $
 * Version: $Revision: 1.23 $
 *
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (C) 2002 - 2011 Alkacon Software (http://www.alkacon.com)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * For further information about Alkacon Software, please see the
 * company website: http://www.alkacon.com
 *
 * For further information about OpenCms, please see the
 * project website: http://www.opencms.org
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package org.opencms.gwt.shared.rpc;

import org.opencms.db.CmsResourceState;
import org.opencms.gwt.shared.CmsAvailabilityInfoBean;
import org.opencms.gwt.shared.CmsCategoryTreeEntry;
import org.opencms.gwt.shared.CmsContextMenuEntryBean;
import org.opencms.gwt.shared.CmsCoreData;
import org.opencms.gwt.shared.CmsLockInfo;
import org.opencms.gwt.shared.CmsValidationQuery;
import org.opencms.gwt.shared.CmsValidationResult;
import org.opencms.gwt.shared.CmsCoreData.AdeContext;
import org.opencms.util.CmsUUID;

import java.util.List;
import java.util.Map;

import com.google.gwt.user.client.rpc.AsyncCallback;
import com.google.gwt.user.client.rpc.SynchronizedRpcRequest;

/**
 * Provides general core services.<p>
 * 
 * @author Michael Moossen
 * @author Ruediger Kurz
 * 
 * @version $Revision: 1.23 $ 
 * 
 * @since 8.0.0
 * 
 * @see org.opencms.gwt.CmsCoreService
 * @see org.opencms.gwt.shared.rpc.I_CmsCoreService
 * @see org.opencms.gwt.shared.rpc.I_CmsCoreServiceAsync
 */
public interface I_CmsCoreServiceAsync {

    /**
     * Creates a new UUID.<p>
     * 
     * @param callback the async callback
     */
    void createUUID(AsyncCallback<CmsUUID> callback);

    /**
     * Returns the categories for the given search parameters.<p>
     * 
     * @param fromCatPath the category path to start with, can be <code>null</code> or empty to use the root
     * @param includeSubCats if to include all categories, or first level child categories only
     * @param refVfsPaths the reference paths, can be <code>null</code> to only use the system repository
     * @param callback the async callback
     */
    void getCategories(
        String fromCatPath,
        boolean includeSubCats,
        List<String> refVfsPaths,
        AsyncCallback<CmsCategoryTreeEntry> callback);

    /**
     * Returns the categories for the given reference site-path.<p>
     * 
     * @param sitePath the reference site-path
     * @param callback the async callback
     */
    void getCategoriesForSitePath(String sitePath, AsyncCallback<CmsCategoryTreeEntry> callback);

    /**
     * Returns a list of menu entry beans for the context menu.<p>
     * 
     * @param uri the URI to the resource to get the context menu for
     * @param context the ade context (sitemap or containerpage)
     * @param callback the asynchronous callback
     */
    void getContextMenuEntries(String uri, AdeContext context, AsyncCallback<List<CmsContextMenuEntryBean>> callback);

    /**
     * Gets the resource state of a resource on a given path.<p>
     * 
     * @param path the resource path 
     * @param callback the callback which receives the result  
     */
    void getResourceState(String path, AsyncCallback<CmsResourceState> callback);

    /**
     * Returns a link for the OpenCms workplace that will reload the whole workplace, switch to the explorer view, the
     * site of the given explorerRootPath and show the folder given in the explorerRootPath.<p>
     * 
     * @param uri the uri to get the workplace link for
     * @param callback the callback which receives the result  
     */
    void getWorkplaceLink(String uri, AsyncCallback<String> callback);

    /**
     * Locks the given resource.<p>
     * 
     * @param uri the resource URI 
     * @param callback the async callback
     */
    @SynchronizedRpcRequest
    void lock(String uri, AsyncCallback<String> callback);

    /**
     * Locks the given resource with a temporary lock.<p>
     * 
     * @param uri the resource URI 
     * @param callback the async callback
     */
    @SynchronizedRpcRequest
    void lockTemp(String uri, AsyncCallback<String> callback);

    /**
     * Locks the given resource with a temporary lock additionally checking that 
     * the given resource has not been modified after the given timestamp.<p>
     * 
     * @param uri the resource URI 
     * @param modification the timestamp to check
     * @param callback the async callback
     */
    @SynchronizedRpcRequest
    void lockTempAndCheckModification(String uri, long modification, AsyncCallback<CmsLockInfo> callback);

    /**
     * Generates core data for prefetching in the host page.<p>
     * 
     * @param callback the async callback
     */
    void prefetch(AsyncCallback<CmsCoreData> callback);

    /**
     * Applies the changes stored in the info bean to the vfs of OpenCms.<p>
     * 
     * @param structureId the structure id of the modified resource
     * @param bean the bean with the information of the dialog
     * @param callback the asynchronous callback
     */
    void setAvailabilityInfo(CmsUUID structureId, CmsAvailabilityInfoBean bean, AsyncCallback<Void> callback);

    /**
     * Applies the changes stored in the info bean to the vfs of OpenCms.<p>
     * 
     * @param vfsPath the vfs path of the modified resource
     * @param bean the bean with the information of the dialog
     * @param callback the asynchronous callback
     */
    void setAvailabilityInfo(String vfsPath, CmsAvailabilityInfoBean bean, AsyncCallback<Void> callback);

    /**
     * Writes the tool-bar visibility into the session cache.<p>
     * 
     * @param visible <code>true</code> if the tool-bar is visible
     * @param callback the call-back executed on response
     */
    void setToolbarVisible(boolean visible, AsyncCallback<Void> callback);

    /**
     * Translates an URL name of a sitemap entry to a valid form containing no illegal characters.<p>
     * 
     * @param urlName the url name to be translated
     * @param callback the async callback 
     */
    void translateUrlName(String urlName, AsyncCallback<String> callback);

    /**
     * Unlocks the given resource.<p>
     * 
     * @param uri the resource URI 
     * @param callback the async callback
     */
    @SynchronizedRpcRequest
    void unlock(String uri, AsyncCallback<String> callback);

    /**
     * Performs a batch of validations and returns the results.<p>
     * 
     * @param validationQueries a map from field names to validation queries
     * @param callback the asynchronous callback 
     */
    void validate(
        Map<String, CmsValidationQuery> validationQueries,
        AsyncCallback<Map<String, CmsValidationResult>> callback);

    /**
     * Performs a batch of validations using a custom form validator class.<p>
     * 
     * @param formValidatorClass the class name of the form validator
     * @param validationQueries a map from field names to validation queries 
     * @param values the map of all field values 
     * @param config the form validator configuration string
     * @param callback the asynchronous callback  
     */
    void validate(
        String formValidatorClass,
        Map<String, CmsValidationQuery> validationQueries,
        Map<String, String> values,
        String config,
        AsyncCallback<Map<String, CmsValidationResult>> callback);

}

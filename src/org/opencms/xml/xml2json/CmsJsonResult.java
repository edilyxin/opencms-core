/*
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (c) Alkacon Software GmbH & Co. KG (http://www.alkacon.com)
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

package org.opencms.xml.xml2json;

import org.opencms.json.JSONObject;

import javax.servlet.http.HttpServletResponse;

/**
 * Result of rendering JSON.
 */
public class CmsJsonResult {

    /** The JSON result data. */
    private Object m_json;

    /** The HTTP status. */
    private int m_status = HttpServletResponse.SC_OK;

    /**
     * Creates a new instance.
     *
     * @param json the JSON data.
     **/
    public CmsJsonResult(JSONObject json) {

        this(json, HttpServletResponse.SC_OK);

    }

    /**
     * Creates a new instance.
     *
     * @param json the JSON data
     * @param status the result
     */
    public CmsJsonResult(Object json, int status) {

        m_json = json;
        m_status = status;
    }

    /**
     * Gets the JSON data.
     * @return the JSON data
     */
    Object getJson() {

        return m_json;

    }

    /**
     * Gets the HTTP status code to set.
     *
     * @return the HTTP status
     */
    int getStatus() {

        return m_status;
    }

}

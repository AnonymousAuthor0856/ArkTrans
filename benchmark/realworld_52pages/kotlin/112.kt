/*
 * Copyright (c) 2023 Samson Achiaga
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.certified.audionote.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.Info
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.ComposeView
import androidx.compose.ui.platform.LocalInspectionMode
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.fragment.app.Fragment
import androidx.navigation.NavController
import androidx.navigation.Navigation
import com.certified.audionote.R
import com.certified.audionote.utils.Extensions.flags
import com.certified.audionote.utils.Extensions.safeNavigate

private val BackgroundColor = Color(0xFFFFECF1)
private val TextPrimary = Color(0xFF000000)
private val TextSecondary = Color(0xFF666666)

class SettingsFragment : Fragment() {

    private lateinit var navController: NavController

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        return ComposeView(requireContext()).apply {
            setContent {
                MaterialTheme {
                    SettingsScreen(
                        onBackClick = {
                            navController.safeNavigate(
                                SettingsFragmentDirections.actionSettingsFragmentToHomeFragment()
                            )
                        },
                        onAboutClick = {
                            navController.safeNavigate(
                                SettingsFragmentDirections.actionSettingsFragmentToAboutFragment()
                            )
                        },
                        childFragmentManager = childFragmentManager
                    )
                }
            }
        }
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        navController = Navigation.findNavController(view)
    }

    override fun onResume() {
        super.onResume()
        flags(R.color.fragment_background)
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SettingsScreen(
    onBackClick: () -> Unit = {},
    onAboutClick: () -> Unit = {},
    childFragmentManager: androidx.fragment.app.FragmentManager? = null
) {
    val isPreview = LocalInspectionMode.current
    val scrollState = rememberScrollState()

    Scaffold(containerColor = BackgroundColor) {
        Column(
            modifier = Modifier
                .padding(it)
                .fillMaxSize()
                .verticalScroll(scrollState)
                .padding(horizontal = 24.dp)
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(vertical = 12.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                IconButton(onClick = onBackClick) {
                    if (isPreview)
                        Icon(Icons.Default.ArrowBack, "Back", tint = TextPrimary)
                    else
                        Icon(painterResource(id = R.drawable.ic_arrow_back_black_24dp), "Back", tint = TextPrimary)
                }
                Spacer(modifier = Modifier.width(8.dp))
                Text(
                    "Settings",
                    style = MaterialTheme.typography.titleLarge.copy(fontWeight = FontWeight.Bold, fontSize = 22.sp),
                    color = TextPrimary
                )
            }

            Spacer(modifier = Modifier.height(16.dp))

            if (!isPreview && childFragmentManager != null) {
                AndroidView(
                    modifier = Modifier.fillMaxWidth().wrapContentHeight(),
                    factory = { ctx ->
                        FrameLayout(ctx).apply {
                            id = View.generateViewId()
                            childFragmentManager.beginTransaction()
                                .replace(id, PreferenceFragment())
                                .commit()
                        }
                    }
                )
            } else {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    colors = CardDefaults.cardColors(containerColor = Color(0xFFF5F5F5))
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Text("Preferences", fontWeight = FontWeight.SemiBold, color = TextPrimary)
                        Spacer(modifier = Modifier.height(8.dp))
                        Text("Settings preferences will appear here", fontSize = 12.sp, color = TextSecondary)
                    }
                }
            }

            Spacer(modifier = Modifier.height(24.dp))
            Divider(color = Color(0xFFE0E0E0))
            Spacer(modifier = Modifier.height(16.dp))

            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .clickable(onClick = onAboutClick)
                    .padding(vertical = 12.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                if (isPreview)
                    Icon(Icons.Default.Info, "Info", tint = TextPrimary, modifier = Modifier.size(24.dp))
                else
                    Icon(painterResource(id = R.drawable.ic_info_black_24dp), "Info", tint = TextPrimary, modifier = Modifier.size(24.dp))
                Spacer(modifier = Modifier.width(16.dp))
                Column {
                    Text(
                        "About", fontSize = 14.sp,
                        fontWeight = FontWeight.SemiBold, color = TextPrimary
                    )
                    Text(
                        "App version, Licence and more", fontSize = 11.sp,
                        color = TextSecondary
                    )
                }
            }
            Spacer(modifier = Modifier.height(32.dp))
        }
    }
}

@Preview(showBackground = true, showSystemUi = true)
@Composable
fun PreviewSettingsScreen() {
    MaterialTheme { SettingsScreen() }
}

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
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.KeyboardArrowRight
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.ComposeView
import androidx.compose.ui.platform.LocalInspectionMode
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.datastore.preferences.core.edit
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.certified.audionote.R
import com.certified.audionote.model.SliderItem
import com.certified.audionote.utils.Extensions.dataStore
import com.certified.audionote.utils.Extensions.safeNavigate
import com.certified.audionote.utils.PreferenceKeys
import kotlinx.coroutines.launch

private val BackgroundColor = Color(0xFFFFECF1)
private val TextPrimary = Color(0xFF000000)
private val ButtonColor = Color(0xFFD29DAC)
private val DotActive = Color(0xFF986977)
private val DotInactive = Color(0xFFAEAEAE)

class OnboardingFragment : Fragment() {

    private lateinit var sliderItems: ArrayList<SliderItem>

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?
    ): View {
        sliderItems = ArrayList<SliderItem>().apply {
            add(SliderItem(R.drawable.ic_undraw_empty,
                getString(R.string.view_pager_title_audio_recording),
                getString(R.string.view_pager_description_audio_recording)))
            add(SliderItem(R.drawable.ic_undraw_empty,
                getString(R.string.view_pager_title_notification),
                getString(R.string.view_pager_description_notification)))
            add(SliderItem(R.drawable.ic_undraw_empty,
                getString(R.string.view_pager_title_dark_mode),
                getString(R.string.view_pager_description_dark_mode)))
        }

        return ComposeView(requireContext()).apply {
            setContent {
                MaterialTheme {
                    OnboardingScreen(
                        items = sliderItems,
                        onGetStarted = {
                            lifecycleScope.launch {
                                requireContext().dataStore.edit {
                                    it[PreferenceKeys.FIRST_TIME_LOGIN] = false
                                }
                                findNavController().safeNavigate(
                                    OnboardingFragmentDirections.actionOnboardingFragmentToHomeFragment()
                                )
                            }
                        }
                    )
                }
            }
        }
    }
}


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun OnboardingScreen(
    items: List<SliderItem> = emptyList(),
    onGetStarted: () -> Unit = {}
) {
    val isPreview = LocalInspectionMode.current
    val displayItems = if (isPreview) previewSliderItems else items
    val pageCount = displayItems.size
    val listState = rememberLazyListState()
    var currentPage by remember { mutableStateOf(0) }
    LaunchedEffect(listState.firstVisibleItemIndex) {
        currentPage = listState.firstVisibleItemIndex
    }

    Scaffold(containerColor = BackgroundColor) { innerPadding ->
        Column(
            modifier = Modifier
                .padding(innerPadding)
                .fillMaxSize()
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            LazyRow(
                modifier = Modifier.weight(1f),
                state = listState
            ) {
                itemsIndexed(displayItems) { index, item ->
                    Box(
                        modifier = Modifier
                            .fillParentMaxWidth()
                            .fillMaxHeight()
                    ) {
                        Column(
                            modifier = Modifier
                                .fillMaxSize()
                                .padding(horizontal = 24.dp),
                            verticalArrangement = Arrangement.Center,
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            if (isPreview) {
                                Icon(
                                    imageVector = Icons.Default.KeyboardArrowRight,
                                    contentDescription = null,
                                    modifier = Modifier.size(120.dp),
                                    tint = TextPrimary.copy(alpha = 0.3f)
                                )
                            } else {
                                Icon(
                                    painter = painterResource(id = item.image),
                                    contentDescription = null,
                                    modifier = Modifier.size(120.dp),
                                    tint = Color.Unspecified
                                )
                            }
                            Spacer(modifier = Modifier.height(32.dp))
                            Text(
                                text = item.title,
                                fontSize = 18.sp,
                                fontWeight = FontWeight.Bold,
                                color = TextPrimary,
                                textAlign = TextAlign.Center
                            )
                            Spacer(modifier = Modifier.height(12.dp))
                            Text(
                                text = item.description,
                                fontSize = 12.sp,
                                color = TextPrimary.copy(alpha = 0.7f),
                                textAlign = TextAlign.Center
                            )
                        }
                    }
                }
            }
            Row(
                horizontalArrangement = Arrangement.spacedBy(8.dp),
                modifier = Modifier.padding(vertical = 16.dp)
            ) {
                repeat(pageCount) { index ->
                    Box(
                        modifier = Modifier
                            .size(if (index == currentPage) 12.dp else 10.dp)
                            .clip(CircleShape)
                            .background(if (index == currentPage) DotActive else DotInactive)
                    )
                }
            }

            Button(
                onClick = onGetStarted,
                modifier = Modifier
                    .fillMaxWidth(0.4f)
                    .height(48.dp),
                colors = ButtonDefaults.buttonColors(containerColor = ButtonColor),
                shape = RoundedCornerShape(12.dp)
            ) {
                Text(
                    "Get Started",
                    fontSize = 14.sp,
                    fontWeight = FontWeight.SemiBold,
                    color = TextPrimary
                )
            }

            Spacer(modifier = Modifier.height(32.dp))
        }
    }
}


private val previewSliderItems = listOf(
    SliderItem(0, "Audio Recording", "Taking notes shouldn't be about typing or writing alone."),
    SliderItem(0, "Notification", "Set a reminder for your notes and get notified."),
    SliderItem(0, "Dark Mode", "Enjoy dark mode for a better night experience.")
)

@Preview(showBackground = true, showSystemUi = true)
@Composable
fun PreviewOnboardingScreen() {
    MaterialTheme { OnboardingScreen(items = previewSliderItems) }
}

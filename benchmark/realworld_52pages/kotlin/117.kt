package com.kin.easynotes.presentation.screens.settings

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.Cloud
import androidx.compose.material.icons.rounded.Info
import androidx.compose.material.icons.rounded.Language
import androidx.compose.material.icons.rounded.Palette
import androidx.compose.material.icons.rounded.TextFields
import androidx.compose.material.icons.rounded.Work
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.res.vectorResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.kin.easynotes.R
import com.kin.easynotes.presentation.components.NavigationIcon
import com.kin.easynotes.presentation.screens.settings.widgets.SectionBlock
import com.kin.easynotes.presentation.screens.settings.widgets.SettingSection
import com.kin.easynotes.presentation.screens.settings.widgets.SupportBox

@OptIn(ExperimentalMaterial3Api::class)
@Preview(showBackground = true)
@Composable
private fun MainSettingsPreview() {
    MaterialTheme {
        Box(modifier = Modifier.fillMaxSize()) {
            // ── Top bar ──
            CenterAlignedTopAppBar(
                title = { Text(stringResource(R.string.screen_settings)) },
                navigationIcon = { NavigationIcon {} },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.background
                )
            )

            Box(modifier = Modifier.padding(16.dp, 72.dp, 16.dp, 16.dp)) {
                LazyColumn(verticalArrangement = Arrangement.spacedBy(28.dp)) {
                    item {
                        SupportBox(
                            title = stringResource(R.string.support),
                            description = stringResource(R.string.support_description),
                            onAction = {}
                        )
                    }
                    item {
                        SectionBlock(
                            listOf(
                                SettingSection(
                                    title = stringResource(R.string.color_styles),
                                    features = listOf(stringResource(R.string.description_color_styles)),
                                    icon = Icons.Rounded.Palette,
                                    onClick = {}
                                ),
                                SettingSection(
                                    title = stringResource(R.string.Behavior),
                                    features = listOf(stringResource(R.string.description_markdown)),
                                    icon = Icons.Rounded.TextFields,
                                    onClick = {}
                                ),
                                SettingSection(
                                    title = stringResource(R.string.language),
                                    features = listOf(stringResource(R.string.description_language)),
                                    icon = Icons.Rounded.Language,
                                    onClick = {}
                                )
                            )
                        )
                    }
                    item {
                        SectionBlock(
                            listOf(
                                SettingSection(
                                    title = stringResource(R.string.backup),
                                    features = listOf(stringResource(R.string.description_cloud)),
                                    icon = Icons.Rounded.Cloud,
                                    onClick = {}
                                ),
                                SettingSection(
                                    title = stringResource(R.string.privacy),
                                    features = listOf(stringResource(R.string.screen_protection)),
                                    icon = ImageVector.vectorResource(R.drawable.incognito_fill),
                                    onClick = {}
                                ),
                                SettingSection(
                                    title = stringResource(R.string.tools),
                                    features = listOf(stringResource(R.string.description_tools)),
                                    icon = Icons.Rounded.Work,
                                    onClick = {}
                                )
                            )
                        )
                    }
                    item {
                        SectionBlock(
                            listOf(
                                SettingSection(
                                    title = stringResource(R.string.about),
                                    features = listOf(stringResource(R.string.description_about)),
                                    icon = Icons.Rounded.Info,
                                    onClick = {}
                                )
                            )
                        )
                    }
                }
            }
        }
    }
}

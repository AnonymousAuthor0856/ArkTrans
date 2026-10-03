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
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.ComposeView
import androidx.compose.ui.platform.LocalInspectionMode
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.NavController
import androidx.navigation.Navigation
import com.certified.audionote.R
import com.certified.audionote.model.Note
import com.certified.audionote.repository.Repository
import com.certified.audionote.utils.Extensions.flags
import com.certified.audionote.utils.Extensions.safeNavigate
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

private val BackgroundColor = Color(0xFFFFECF1)
private val TextPrimary = Color(0xFF000000)
private val TextSecondary = Color(0xFF666666)
private val FabColor = Color(0xFFEFB8C8)

@AndroidEntryPoint
class HomeFragment : Fragment() {

    @Inject
    lateinit var repository: Repository
    private val viewModel: NotesViewModel by viewModels()
    private lateinit var navController: NavController

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?
    ): View {
        return ComposeView(requireContext()).apply {
            setContent {
                MaterialTheme {
                    HomeScreen(
                        viewModel = viewModel,
                        onNoteClick = { note ->
                            navController.safeNavigate(
                                HomeFragmentDirections.actionHomeFragmentToEditNoteFragment(note)
                            )
                        },
                        onSettingsClick = {
                            navController.safeNavigate(
                                HomeFragmentDirections.actionHomeFragmentToSettingsFragment()
                            )
                        },
                        onAddClick = {
                            navController.safeNavigate(
                                HomeFragmentDirections.actionHomeFragmentToAddNoteFragment(
                                    Note(audioLength = 0L)
                                )
                            )
                        }
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
fun HomeScreen(
    viewModel: NotesViewModel? = null,
    onNoteClick: (Note) -> Unit = {},
    onSettingsClick: () -> Unit = {},
    onAddClick: () -> Unit = {}
) {
    val isPreview = LocalInspectionMode.current
    val raw by (viewModel?.notes?.collectAsState(initial = null) ?: remember { mutableStateOf<List<Note>?>(null) })
    val notes = raw ?: emptyList()

    Scaffold(
        containerColor = BackgroundColor,
        floatingActionButton = {
            FloatingActionButton(
                onClick = onAddClick,
                containerColor = FabColor,
                shape = RoundedCornerShape(16.dp)
            ) {
                if (isPreview)
                    Icon(Icons.Default.Mic, "Add note", tint = TextPrimary, modifier = Modifier.size(28.dp))
                else
                    Icon(painterResource(id = R.drawable.ic_mic_black_24dp), "Add note", tint = TextPrimary, modifier = Modifier.size(28.dp))
            }
        }
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .padding(innerPadding)
                .fillMaxSize()
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(start = 16.dp, top = 16.dp, end = 8.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Column(modifier = Modifier.weight(1f)) {
                    Text(
                        "Hi there!",
                        style = MaterialTheme.typography.titleMedium.copy(
                            fontWeight = FontWeight.Bold, fontSize = 18.sp
                        ),
                        color = TextPrimary
                    )
                    Text(
                        "Welcome back",
                        fontSize = 12.sp,
                        color = TextPrimary.copy(alpha = 0.7f)
                    )
                }
                IconButton(onClick = onSettingsClick) {
                    if (isPreview)
                        Icon(Icons.Default.Settings, "Settings", tint = TextPrimary)
                    else
                        Icon(painterResource(id = R.drawable.ic_settings_black_24dp), "Settings", tint = TextPrimary)
                }
            }

            Spacer(modifier = Modifier.height(16.dp))

            if (notes.isEmpty() && !isPreview) {
                Column(
                    modifier = Modifier.fillMaxSize(),
                    verticalArrangement = Arrangement.Center,
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Icon(
                        painter = painterResource(id = R.drawable.ic_undraw_empty),
                        contentDescription = null,
                        modifier = Modifier.size(120.dp),
                        tint = Color.Unspecified
                    )
                    Spacer(modifier = Modifier.height(8.dp))
                    Text(
                        "Your record list is empty.\nClick the button below to get started.",
                        fontSize = 12.sp,
                        color = TextPrimary.copy(alpha = 0.7f),
                        textAlign = TextAlign.Center
                    )
                }
            } else {
                // ── Notes grid ───────────────────────────────────
                val displayNotes: List<Note> = if (isPreview) previewNotes else notes
                LazyVerticalGrid(
                    columns = GridCells.Fixed(2),
                    contentPadding = PaddingValues(horizontal = 8.dp, vertical = 8.dp),
                    horizontalArrangement = Arrangement.spacedBy(8.dp),
                    verticalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    items(displayNotes, key = { it.id }) { note ->
                        NoteCard(note = note, onClick = { onNoteClick(note) })
                    }
                }
            }
        }
    }
}


@Composable
fun NoteCard(note: Note, onClick: () -> Unit) {
    val cardColor = Color(note.color)
    val reminder = note.reminder
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clickable(onClick = onClick),
        colors = CardDefaults.cardColors(containerColor = cardColor),
        shape = RoundedCornerShape(8.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
    ) {
        Column(
            modifier = Modifier
                .background(cardColor)
                .padding(8.dp)
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Text(
                    text = note.title,
                    fontSize = 12.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                    modifier = Modifier.weight(1f)
                )
                Spacer(modifier = Modifier.width(4.dp))
                Text(
                    text = formatDateStamp(note.lastModificationDate),
                    fontSize = 10.sp,
                    color = Color.White,
                    maxLines = 1
                )
            }
            Spacer(modifier = Modifier.height(8.dp))
            Row(
                modifier = Modifier.fillMaxWidth(),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Icon(
                    Icons.Default.Mic,
                    contentDescription = null,
                    tint = Color.White,
                    modifier = Modifier.size(14.dp)
                )
                Spacer(modifier = Modifier.width(4.dp))
                Text(
                    text = formatAudioLength(note.audioLength),
                    fontSize = 12.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Spacer(modifier = Modifier.weight(1f))
                Text(
                    text = note.size,
                    fontSize = 12.sp,
                    color = Color.White
                )
            }
            Spacer(modifier = Modifier.height(8.dp))
            Row(
                modifier = Modifier.fillMaxWidth(),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Icon(
                    Icons.Default.Alarm,
                    contentDescription = null,
                    tint = Color.White.copy(alpha = 0.6f),
                    modifier = Modifier.size(14.dp)
                )
                Spacer(modifier = Modifier.width(4.dp))
                Text(
                    text = if (reminder != null) formatReminderText(reminder)
                    else "No reminder set",
                    fontSize = 12.sp,
                    color = Color.White.copy(alpha = 0.6f),
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                    textDecoration = if (reminder != null &&
                        System.currentTimeMillis() > reminder
                    ) TextDecoration.LineThrough else TextDecoration.None
                )
            }
        }
    }
}

private fun formatDateStamp(millis: Long): String {
    if (millis <= 0) return ""
    val cal = java.util.Calendar.getInstance().apply { timeInMillis = millis }
    return "${cal.get(java.util.Calendar.DAY_OF_MONTH)}/${cal.get(java.util.Calendar.MONTH) + 1}/${cal.get(java.util.Calendar.YEAR) % 100}"
}

private fun formatAudioLength(seconds: Long): String {
    if (seconds <= 0) return "00:00"
    val m = seconds / 60
    val s = seconds % 60
    return String.format("%02d:%02d", m, s)
}

private fun formatReminderText(millis: Long): String {
    val cal = java.util.Calendar.getInstance().apply { timeInMillis = millis }
    val day = cal.get(java.util.Calendar.DAY_OF_MONTH)
    val month = cal.get(java.util.Calendar.MONTH) + 1
    val year = cal.get(java.util.Calendar.YEAR)
    val hour = cal.get(java.util.Calendar.HOUR_OF_DAY)
    val min = cal.get(java.util.Calendar.MINUTE)
    return String.format("%d/%d/%d %02d:%02d", day, month, year % 100, hour, min)
}


private val previewNotes = listOf(
    Note(id = 1, title = "CPE 407 - Lecture 1", audioLength = 2185, size = "46MB", reminder = System.currentTimeMillis() + 86400000, color = 0xFFD29DAC.toInt()),
    Note(id = 2, title = "Meeting Notes", audioLength = 600, size = "12MB", reminder = null, color = 0xFFEFB8C8.toInt()),
    Note(id = 3, title = "Project Ideas", audioLength = 120, size = "3MB", reminder = System.currentTimeMillis() - 86400000, color = 0xFF986977.toInt()),
    Note(id = 4, title = "Shopping List", audioLength = 0, size = "1MB", reminder = null, color = 0xFFD29DAC.toInt())
)


@Preview(showBackground = true, showSystemUi = true)
@Composable
fun PreviewHomeScreen() {
    MaterialTheme { HomeScreen() }
}

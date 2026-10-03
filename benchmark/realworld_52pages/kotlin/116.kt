package com.kin.easynotes.presentation.screens.home

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.Search
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SearchBar
import androidx.compose.material3.SearchBarDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.kin.easynotes.domain.model.Note
import com.kin.easynotes.presentation.components.markdown.MarkdownText

private val sampleNotes = listOf(
    Note(1, "Shopping List", "- Milk\n- Eggs\n- Bread\n- Butter", pinned = true),
    Note(2, "Meeting Notes", "Discussed **Q3 roadmap** and *budget*.\n\n1. Draft proposal\n2. Review with team"),
    Note(3, "Ideas", "> The best way to predict the future is to invent it.\n\n— Alan Kay"),
)

@OptIn(ExperimentalMaterial3Api::class)
@Preview(showBackground = true)
@Composable
private fun HomeViewPreview() {
    MaterialTheme {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .background(MaterialTheme.colorScheme.background)
        ) {
            SearchBar(
                query = "",
                onQueryChange = {},
                onSearch = {},
                active = false,
                onActiveChange = {},
                placeholder = { Text("Search") },
                leadingIcon = { Icon(Icons.Rounded.Search, contentDescription = null) },
                trailingIcon = {
                    Icon(
                        Icons.Rounded.Search, contentDescription = null,
                        tint = MaterialTheme.colorScheme.onSurfaceVariant,
                        modifier = Modifier.padding(end = 6.dp)
                    )
                },
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(32.dp, 16.dp, 32.dp, 18.dp),
                colors = SearchBarDefaults.colors(
                    containerColor = MaterialTheme.colorScheme.surfaceContainerLow
                )
            ) {}

            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .verticalScroll(rememberScrollState())
                    .padding(horizontal = 12.dp)
            ) {
                sampleNotes.forEach { note ->
                    Spacer(modifier = Modifier.height(12.dp))
                    NoteCardItem(note)
                }
            }
        }
    }
}

@Composable
private fun NoteCardItem(note: Note) {
    val shape = RoundedCornerShape(16.dp)
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .clip(shape)
            .background(MaterialTheme.colorScheme.surfaceContainer)
            .padding(16.dp, 12.dp, 16.dp, 12.dp)
    ) {
        Column {
            if (note.name.isNotBlank()) {
                MarkdownText(
                    isPreview = true, isEnabled = true,
                    markdown = note.name.replaceFirstChar { it.uppercase() },
                    modifier = Modifier.heightIn(max = 64.dp),
                    weight = FontWeight.Bold, spacing = 0.dp,
                    fontSize = 20.sp, radius = 16
                )
                if (note.description.isNotBlank()) Spacer(Modifier.height(9.dp))
            }
            if (note.description.isNotBlank()) {
                MarkdownText(
                    isPreview = true, markdown = note.description,
                    isEnabled = true, spacing = 0.dp,
                    modifier = Modifier.heightIn(max = 96.dp),
                    fontSize = 16.sp, radius = 16
                )
            }
        }
    }
}

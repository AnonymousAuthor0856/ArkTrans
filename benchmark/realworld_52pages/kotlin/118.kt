package com.kin.easynotes.presentation.screens.terms

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.kin.easynotes.R
import com.kin.easynotes.presentation.components.AgreeButton
import com.kin.easynotes.presentation.components.material.MaterialScaffold
import com.kin.easynotes.presentation.components.markdown.MarkdownText
import com.kin.easynotes.presentation.screens.settings.settings.shapeManager

@Preview(showBackground = true)
@Composable
private fun TermsScreenPreview() {+
    
    val cornerRadius = 32 

    MaterialScaffold(
        floatingActionButton = {
            AgreeButton(
                text = stringResource(R.string.agree),
                modifier = Modifier.semantics { contentDescription = "Agree" }
            ) { }
        },
        content = {
            Column(modifier = Modifier.padding(16.dp)) {
                Text(
                    text = stringResource(R.string.terms_of_service),
                    style = MaterialTheme.typography.headlineLarge,
                    modifier = Modifier.padding(0.dp, 16.dp, 16.dp, 16.dp)
                )
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .clip(shapeManager(isBoth = true, radius = cornerRadius))
                        .background(MaterialTheme.colorScheme.surfaceContainerHigh.copy(alpha = 0.5f))
                        .padding(1.dp)
                        .semantics { contentDescription = "Terms" }
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        MarkdownText(
                            fontSize = 12.sp,
                            radius = cornerRadius,
                            markdown = getTermsOfService(),
                            isEnabled = true
                        )
                    }
                }
            }
        }
    )
}
